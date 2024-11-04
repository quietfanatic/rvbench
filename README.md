This is a collection of benchmarks for RISC-V function implementations.  So far, only memcpy is tested.

#### Running
```
perl make.pl --jobs=7  # compile, run, and tabulate stats
perl make.pl clean_stats  # clear cached stats
perl make.pl clean  # clear all products and temporary files
perl make.pl --jobs=7 out/memcpy/stats  # run only stats for memcpy implementations
perl make.pl --jobs=7 out/<other>/stats  # run only stats for something else
```

#### Example Output (perl make.pl out/memcpy/stats)
```
MEMCPY                 three   16a   32a   32s   32u   64a  128a  256a   2ka   2ks   2ku  64ka   rnd  test
---------------------------------------------------------------------------------------------------------
         e8m1_ialign:   122   182   111   112   112   202   385   745   518   583   585   872  1602  pass
      e8m1_no_ialign:   122   112   112   122   122   192   353   674   519   583   585   903  1594  pass
                e8m2:   132   132   132   142   142   132   238   508   423   465   467   881  1558  pass
                e8m4:   172   172   172   182   182   172   182   433   380   412   416   704  1247  pass
                e8m8:   323   322   323   343   343   327   323   422   375   400   396   729  1189  pass
           e8any_1_1:   120   111   112   111   112   172   262   433   370   394   394   673  1219  pass
           e8any_1_2:   120   111   111   112   112   172   262   423   377   394   391   697  1313  pass
    e8any_1_2_ialign:   120   111   110   111   111   172   262   423   378   393   392   659  1238  pass
           e8any_1_3:   122   111   114   111   111   172   262   423   374   392   391   643  1244  pass
           e8any_1_4:   120   113   111   111   111   172   262   403   378   394   394   676  1220  pass
    e8any_1_4_ialign:   121   112   110   112   112   172   263   424   377   392   392   694  1241  pass
               e8con:   119   111   111   112   111   172   262   405   306   313   319   663  1195  pass
              e8prog:   121   111   112   112   111   202   353   745   411   433   433   994  1750  pass
       e8prog_ialign:   119   182   111   111   115   222   385   805   408   434   432   879  1658  pass
          glibc_2_39:   192   162   162   163   161   226   309   583   399   400   459  1001  1615  pass
          glibc_2_40:   199   368   372   366   373   503   743   943   417   393   455  1493  1846  pass
               dummy:    81    79    80    77    79    78    77    80    10    10    10     1     2  fail
```

#### Conclusions

Here are some things I've learned about the processor I have, which is a
SpacemiT K1:

- Misaligned access is supported and fast for scalars.  The stdlib memcpy takes
  advantage of this.
- Misaligned access is *not* supported for vector elements.  For instance, if
  you load or store 64-bit elements, they must be aligned to 8 bytes, or you get
  a Bus Error.
- But that doesn't matter, because loading and storing 8-bit vector elements is
  just as fast as 64-bit elements, and with no alignment constraints.
- Using vectors can reduce execution time by 10~50% (on this core) and code
  size of some functions by up to 90% (not a typo).
- Counterintuitively, where vectors shine the most is when working with small
  irregular data lengths, because the same codepath can run on 0~32 bytes
  without branching based on the length.
- Using an lmul larger than necessary has a significant performance impact.  In
  theory, a processor should be able to see that the higher lmul is
  unnecessary, and pretend that it has a lower lmul, but this processor cannot
  do that.
- Aligning loops to 8 bytes makes a significant difference for instruction-
  limited code, but not as much for bandwidth-limited code (which likely
  includes a lot of vector-heavy functions).
- This is a dual-issue in-order CPU, so it's most efficient to schedule
  instructions so that one instruction doesn't depend on the one immediately
  before it.  This may not matter if throughput is limited by other factors.
- This processor can only do one load or one store per cycle.  You can load a
  value and immediately store it the next cycle.  Doing multiple loads then
  multiple stores seems to be slightly slower than alternating loads and stores.
- An instruction cannot pair with another instruction if the first writes a
  register that is read or written by the second.  An exception is when the
  first is an lui or auipc, which seem to pair with just about any other
  instruction, regardless of whether it reads or writes the register that the
  first one wrote.
- Only one canonical nop can be executed per cycle, including compressed nops.
  This is likely because the nop is taken at face value as "addi x0,x0,0", which
  both reads and writes the x0 register, so there is a false dependency between
  consecutive nops.  If you alternate the canonical nop with another instruction
  that doesn't affect state, such as "addi x31,x31,0", then they can execute 2
  per cycle.
- Correctly predicted branch instructions are removed from the pipeline, which
  can result in a reported IPC greater than 2.  It's likely that an instruction
  before a taken branch can pair with the instruction after the branch.
- Using compressed instructions can have erratic effects on performance, usually
  positive but occasionally negative.  There may be a penalty for a 4-byte
  instruction that crosses an 8-byte alignment boundary.

#### memcpy
On this processor, the ideal memcpy implementation appears to be some variation
on this function, which selects the lmul based on how much data is left to
transfer.
```
.align 3
memcpy:
     # Check if the entire transfer fits in m1, m2, or m4
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    mv a3,a0
     # Start looping with m8
3:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    bne a4,a2,2f
    ret
2:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a3,a4
     # See if we can use smaller lmul for the tail
    vsetvli a4,a2,e8,m1,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,4f
    vsetvli a4,a2,e8,m4,ta,ma
    bne a4,a2,3b
4:  vle8.v v8,(a1)
    vse8.v v8,(a3)
    ret
```
Strangely, this function appears to be always faster on large blocks than the
simpler version where you replace everything from the "See if..." comment onward
with "j 3b".  Even though it's strictly doing more instructions and branches, it
runs faster even when always selecting m8.  There is still much about this
processor that remains mysterious.

On a more sophisticated processor, it'll probably be fastest to just use m8 for
everything.
```
memcpy:
    mv a3,a0
1:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    vse8.v v8,(a3)
    bne a4,a2,0f
    ret
0:  add a1,a1,a4
    sub a2,a2,a4
    add a3,a3,a4
    j 1b
```

##### memcmp
Benchmarks of memcmp are incomplete and not typical of ordinary programs.  I'm
guessing that in most programs, most string comparisons will find a difference
within the first 32 or so characters, and if the comparison progresses longer,
it's likely the strings will be equal.  With that in mind, it's probably better
to take a progressive approach: always start with m1, and if there's more to
process, use m2, then m4, and then m8.  Or possibly even start with m1 and then
go straight to m8.

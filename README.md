This is a collection of benchmarks for RISC-V function implementations.  So far, only memcpy is tested.

#### Running
```
perl make.pl --jobs=7  # compile, run, and tabulate stats
perl make.pl clean_stats  # clear cached stats
perl make.pl clean  # clear all products and temporary files
```

#### Example Output
```
MEMCPY                three   32a   32s   32u   64a  128a  256a   2ka   2ks   2ku  64ka  test
---------------------------------------------------------------------------------------------
              byte_c:   237   341  1118  1120   434   676  1171   798  6207  6201   878  pass
         byte_ialign:   202   792   797   794  1440  2726  5352  4138  4139  4151  2119  pass
      byte_no_ialign:   209  1084  1084  1084  2052  3999  7914  6198  6197  6197  2515  pass
         e8m1_ialign:   121   112   111   112   202   383   745   518   583   583   866  pass
      e8m1_no_ialign:   122   112   121   121   193   353   675   519   585   583   886  pass
                e8m2:   142   133   142   142   132   238   508   421   464   465   856  pass
                e8m4:   182   173   182   182   172   182   433   378   414   419   705  pass
                e8m8:   333   323   342   344   328   323   423   378   399   398   687  pass
           e8any_1_1:   122   111   111   111   176   262   423   375   394   394   682  pass
           e8any_1_2:   121   112   111   112   172   262   403   378   394   394   683  pass
    e8any_1_2_ialign:   122   111   112   111   172   262   425   379   393   394   701  pass
           e8any_1_3:   122   111   112   112   172   262   393   378   394   391   662  pass
           e8any_1_4:   122   110   111   111   172   263   423   377   390   393   679  pass
    e8any_1_4_ialign:   122   112   111   112   172   263   423   375   394   393   881  pass
              e8prog:   120   111   111   111   202   343   750   414   435   437   877  pass
       e8prog_ialign:   122   113   111   111   222   385   805   412   435   437   997  pass
          glibc_2_39:   192   162   162   164   223   310   593   400   401   463   966  pass
          glibc_2_40:   199   372   364   364   497   742   934   413   394   450  1256  pass
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
  before it.  How much of an effect this has may depend on other factors.
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

A more sophisticated processor would probably run faster just using m8 for
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

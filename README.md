This is a collection of benchmarks for RISC-V function implementations.  So far, only memcpy is reasonably well tested.

### Running

```
perl make.pl --jobs=7  # compile, run, and tabulate stats
perl make.pl clean_stats  # clear cached stats
perl make.pl clean  # clear all products and temporary files
perl make.pl --jobs=7 out/memcpy/stats  # run only stats for memcpy implementations
perl make.pl --jobs=7 out/<other>/stats  # run only stats for something else
```

##### Example output (out/memcpy/stats)

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

### Analysis

Here are some things I've learned about the processor I have, which is a
SpacemiT K1 (aka SpacemiT X60 (possibly aka XuanTie C908)):

##### Vector processing

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

##### General instruction behavior

- Aligning loops to 8 bytes can make a significant difference for instruction-
  limited code, but not as much for bandwidth-limited code (which likely
  includes a lot of vector-heavy functions).
- Using compressed instructions usually improves performance, but occasionally
  reduces it.  There are probably some code alignment issues I don't understand
  yet.
- This is a dual-issue in-order CPU, so it's most efficient to schedule
  instructions so that one instruction doesn't depend on the one immediately
  before it.  If you have two dependency chains, interleave them with
  alternating instructions.  A long-running instruction allows more instructions
  to run one-at-a-time until it finishes, so scheduling instructions isn't as
  important when you're doing floating point division or vector processing.
- lui and auipc can fuse with intructions that have a 12-bit immediate, such as
  addi, ld, sd, etc.  This allows the instructions to run as a single unit even
  if they use the same register.  The fused unit can even be paired with another
  instruction before or after it, which can bring the IPC above 2.  However the
  combination of fusing and pairing is only possible if some or all of the
  instructions are in compressed format, since the fetcher can only fetch around
  8 bytes at a time (2 uncompressed instructions).  In the rare case where all 4
  instructions are compressed, a fused unit can pair with another fused unit,
  bringing the IPC up to 4.  This can only happen if the immediates fit in bits
  0x0003f03f (0x0001f01f for positive numbers).
- Only one canonical nop can be executed per cycle, including compressed nops.
  This is likely because the nop is taken at face value as "addi x0,x0,0", which
  both reads and writes the x0 register, so there is a false dependency between
  consecutive nops.  If you alternate the canonical nop with another instruction
  that doesn't affect state, such as "addi x31,x31,0", then they can execute 2
  per cycle.
- Correctly predicted branch instructions are removed from the pipeline, which
  can result in a reported IPC greater than 2.  An instruction before an untaken
  branch can pair with one after it, and maybe for a taken branch too. There's a
  limit of 1 untaken branch per cycle.  Taken branches are a bit slower.
  Despite the alleged 8-stage pipeline, branch mispredictions seem kinda bad,
  but the branch predictor seems pretty good.  In one test it appeared to fully
  learn a repeating random pattern of period 127.
- It's not very advertised, but this CPU supports Zicond with the czero
  instructions for branchless programming.  czero cannot fuse, so it should be
  interleaved with pairable instructions.  It's still typically faster than a
  short branch unless the branch is close to 100% predictable.

##### Integer instructions

- 32-bit scalar integer multiplication has a latency of 3 cycles, and 64-bit
  multiplication takes 5.  Two multiplications can be done 1 cycle apart, but
  the third and further need 3 cycles each.  mulh takes 6 cycles and doesn't
  fuse with mul.  A mulh;mul sequence can fuse into a 64x64=128 multiplication,
  as long as neither instruction overwrites an input register (which is more
  strict than the official guidelines for fusing mulh and mul, which only
  require that the first instruction doesn't overwrite an input register).  This
  fused multiplication has a latency of 7 cycles and occupies both execution
  units for 3 cycles (4 unrelated single-cycle instructions can run during the
  multiplication).
- Integer division is weirdly fast, with a data-independent latency of 4 cycles
  for both 32-bit and 64-bit.  The divider is half-pipelined so one division can
  be done every 2 cycles.  Division and remainder instructions cannot fuse
  together, so a div;rem sequence has a total latency of 6 cycles (4 each,
  overlapped by 2).

##### Floating point instructions

- Floating-point addition has a latency of 4 cycles for all precisions and
  rounding modes.
- FP multiplication has a latency of 4 for single- or half-precision and 5 for
  double-precision.  Two floating point multiplications can run simultaneously.
- Floating-point division and square-root are very slow, with a latency of 16
  for single precision, 24 for double, and 13 for half.  Integer and FP division
  do not share an execution unit.  The floating point divider is not pipelined
  except for the first/last cycle, so you can divide every 15, 23, or 12 cycles.
- There is no penalty for NaN or subnormal numbers.

##### Loads and stores

- For the most part, the processor can do one load and one store per cycle, but
  not two loads or two stores.  However, two load or store instructions can be
  fused together into a single load/store if all of the following are true:
    1. They're both 32-bit or both 64-bit
    2. They both use the same base register
    3. The second offset is 4 (32-bit) or 8 (64-bit) larger than the first (it
       doesn't work if the other way around)
    4. The offsets are naturally aligned (the base register and therefore the
       calculated address don't have to be aligned)
    5. In the case of loads, the first instruction doesn't write to any register
       mentioned in the second instruction
  As with fused upper+lower instructions, these fused instructions can run in
  parallel with other instructions, but only if enough of them are compressed.
- Loads and stores are the same speed regardless of data size.  Misaligned
  access causes little if any delay.  Overlapping loads and stores may cause
  delays.
- There's a store-forwarding delay if you load data that was just stored.  If
  the load is fully contained in the store, it's 2 cycles if both addresses are
  aligned and 3 if they aren't.  If the load is larger than or partially
  overlaps the store, the delay can be 3, 8, or 12 cycles depending on various
  size and alignment concerns.  In the case of `sw a0,0(a1); ld a0,0(a1)` the
  delay is 8 cycles, so try not to do that.

#### What's the fastest memcpy?

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

#### What's the fastest memcmp?

Benchmarks of memcmp are incomplete and not typical of ordinary programs.  I'm
guessing that in most programs, most string comparisons will find a difference
within the first 32 or so characters, and if the comparison progresses longer,
it's likely the strings will be equal.  With that in mind, it's probably better
to take a progressive approach: always start with m1, and if there's more to
process, use m2, then m4, and then m8.  Or possibly even start with m1 and then
go straight to m8.

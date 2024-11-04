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
MEMCPY                three   16a   32a   32s   32u   64a  128a  256a   2ka   2ks   2ku  64ka  64ko  rnda  rndo  rndu  test
---------------------------------------------------------------------------------------------------------------------------
          glibc_2_39:   192   162   162   162   162   224   302   605   403   413   458   974   872  1826  1698  1419  pass
          glibc_2_40:   204   371   363   369   371   503   745   936   379   366   446   779   789  2056  1979  2002  pass
             e8m1_ia:   121   182   111   111   111   202   384   747   526   582   584   887  1144  1637  1482  1777  pass
                e8m1:   122   112   111   122   122   192   356   679   519   585   584   868   820  1499  1668  2066  pass
              e8m1_2:   122   202   132   132   132   212   373   696   458   521   523   877   849  1514  1547  1757  pass
                e8m2:   131   132   131   145   142   132   237   510   423   464   467   898   813  1579  1702  1835  pass
                e8m4:   172   172   172   184   182   172   182   432   378   416   414   711   661  1252  1726  2107  pass
                e8m8:   324   323   323   343   343   328   324   425   376   398   399   669   605  1228  2486  2095  pass
           e8any_1_1:   121   112   112   112   112   172   262   423   375   391   393   657   831  1177  2015  1813  pass
      e8conservative:   122   112   112   111   112   172   262   396   305   325   324   647   611  1241  1878  2288  pass
       e8progressive:   121   112   113   111   112   204   343   745   409   435   436  1106   863  1779  1880  1697  pass
           e8any_al2:   121   112   114   112   112   172   292   396   375   435   438   687   604  1334  1187  2038  pass
           e8any_as2:   121   112   111   113   112   172   264   394   379   435   438   679   622  1233  1223  1067  pass
           e8any_as3:   122   111   111   112   112   172   266   393   376   438   439   685   847  1226  1707  1799  pass
           e8any_as4:   122   172   113   111   112   182   278   404   372   434   434   708   950  1227  1209  1074  pass
           e8any_as5:   121   111   112   112   112   172   264   398   375   432   427   663   614  1237  1301  1082  pass
           e8any_as6:   121   172   112   112   113   182   274   394   373   427   429   746   901  1208  1259  1097  pass
       e8any_as2_2sc:   122   112   112   112   112   172   264   394   375   437   435   671   889  1218  1645  1914  pass
        e8any_as2_tl:   122   112   112   111   112   172   264   396   327   381   380   655   824  1214  1684  1898  fail
     e8any_as2_noppy:   121   173   112   112   111   182   307   406   353   395   395   691   910  1228  1686  1929  pass
           e8con_as2:   121   112   112   112   111   172   265   394   306   345   343   675   978  1246  1667  1968  pass
           e8con_as3:   123   162   123   121   122   192   284   433   339   379   378   652   751  1199  1834  1667  pass
            e8m8_as2:   324   393   353   353   353   348   347   463   375   424   425   664   934  1220  1858  1629  pass
               dummy:    81    73    73    75    74    76    74    73     9     9    10     1     1     2     3     3  fail
```

##### Known issue

Occasionally the linux perf tools will return an absurdly large number for the
cycle count.  If you see this in the chart, please make `clean_stats` and try
again.

### Analysis

Here are some things I've learned about the processor I have, which is a
SpacemiT K1 (aka SpacemiT X60 (possibly aka XuanTie C908)):

##### General instruction behavior

- This is a dual-issue in-order CPU, so it's most efficient to schedule
  instructions so that one instruction doesn't depend on the one immediately
  before it.  If you have two dependency chains, interleave them with
  alternating instructions.  A long-running instruction allows more instructions
  to run one-at-a-time until it finishes, so scheduling instructions isn't as
  important when you're doing floating point division or vector processing.
- Using compressed instructions usually improves performance, but occasionally
  reduces it.  There are probably some code alignment issues I don't understand
  yet.
- Aligning loops to 8 bytes can make a significant difference for instruction-
  limited code, but not as much for bandwidth-limited code (which likely
  includes a lot of vector-heavy functions).
- lui and auipc can fuse with intructions that make sense with them, such as
  addi, ld, sd, etc.  This allows the instructions to run as a single unit even
  if they use the same register.  The fused unit can even run in parallel with
  another instruction before or after it, which can bring the IPC above 2.
  However the combination of fusing and ILP is only possible if some or all of
  the instructions are in compressed format, since the fetcher can only fetch
  around 8 bytes at a time (2 uncompressed instructions).  In the rare case
  where all 4 instructions are compressed, a fused unit can run in parallel with
  another fused unit, bringing the IPC up to 4.  This can only happen if the
  immediates fit in bits 0x0003f03f (0x0001f01f for positive numbers).
- Only one canonical nop can be executed per cycle, including compressed nops.
  This is likely because the nop is taken at face value as "addi x0,x0,0", which
  both reads and writes the x0 register, so there is a false dependency between
  consecutive nops.  If you alternate the canonical nop with another instruction
  that doesn't affect state, such as "addi x31,x31,0", then they can execute 2
  per cycle.
- Correctly predicted branch instructions are removed from the pipeline, which
  can result in a reported IPC greater than 2.  An instruction before an untaken
  branch can run in parallel with one after it, and maybe for a taken branch
  too. There's a limit of 1 untaken branch per cycle.  Taken branches are a bit
  slower.  Despite the alleged 8-stage pipeline, branch mispredictions seem
  kinda bad, but the branch predictor seems pretty good.  In one test it
  appeared to fully learn a repeating random pattern of period 127.
- It's not very advertised, but this CPU supports Zicond with the czero
  instructions for branchless programming.  czero cannot fuse, so it should be
  interleaved with pairable instructions.  It's still typically faster than a
  short branch unless the branch is close to 100% predictable.

##### Loads and stores

- Loads have 2-cycle latency and 1-per-cycle throughput if they hit the L1
  cache.  Up to two stores can occur during one load, as long as they "probably"
  don't overlap the load.  If a store uses the same base register as a load, the
  (absence of) overlap can be detected perfectly using the immediate offsets;
  otherwise overlap is detected if the addresses of any affected bytes share all
  of bits 4 through 11 (0x0ff0).  In practical terms, this means the transfers
  are considered potentially overlapping if they touch the same 16-byte aligned
  block modulo 4096.  Performance may be reduced when accessing closely-packed
  data with multiple base registers, or when working with data sets spaced an
  exact multiple of 4096 bytes apart.
- Two loads or two stores cannot start on the same cycle, unless...
- Two consecutive load or store instructions can be fused into a single
  load/store if all of the following are true:
    1. They're both 32-bit or both 64-bit (not 8- or 16-bit)
    2. They both use the same base register
    3. The second offset is larger than the first by exactly 4 (32-bit) or 8
       (64-bit); the first can't be larger than the second.
    4. The offsets are naturally aligned (the base register and therefore the
       calculated address don't have to be aligned)
    5. In the case of loads, the first instruction doesn't write to any register
       mentioned in the second instruction
  As with fused upper+lower instructions, these fused instructions can run in
  parallel with other instructions, but only if enough of them are compressed to
  overcome instruction fetch bandwidth.  When you're saving/restoring
  caller-saved registers, try to do it with fusable load/store pairs.
- Fused loads and stores can't run in parallel very well with other loads and
  stores.
- Scalar loads and stores are the same speed regardless of data size.
  Misaligned accesses by themselves cause little if any delay, but when mixed
  with other loads and stores things may generally run around 30% slower.
- There's a store-forwarding delay if you load data that was just stored.  If
  the store is aligned and the load is fully contained in it, the delay is 1
  extra cycle, for an end-to-end latency of 4 cycles (1 for store, 1 for delay,
  2 for load).  If the store is misaligned or the load is larger than or
  partially overlaps the store, the delay can be 2 (5), 7 (10), or 11 (14)
  cycles depending on various size and alignment concerns.  The sequence of `sw
  a0,0(a1); ld a2,0(a1)` has a latency of 10 from a0 to a2, so try not to do
  that.  Like the overlap detection mentioned above, a false dependency occurs
  when addresses are spaced a multiple of 4096 apart.
- Storing to the same location twice in rapid succession may also incur a
  1-cycle delay; more if the stores are partially overlapping.
- Under ideal conditions, vector loads have a latency of 3 cycles per lmul with
  throughput 1 per 2 cycles, and vector stores have a latency of 2 cycles per
  lmul with same throughput.  With lmul=1, there's about a half-cycle penalty
  for addresses that aren't 16-byte aligned or a 1-cycle penalty for addresses
  that aren't 8-byte aligned.  This penalty is only about double with lmul=8.
  Unlike with scalars, vector stores don't parallelize with vector loads very
  well.
- In general, loads and stores seem to behave inconsistently.  Often store-heavy
  code runs about 30% slower than it seems like it should.  Sometimes running
  calculation instructions during loads and stores actually makes them faster
  (as opposed to making the loads and stores wait for one another).  It probably
  all depends on the mood of the caches and prefetcher.

##### Vector processing

- Despite misaligned access being supported for scalars, it is *not* supported
  for vector elements.  For instance, if you load or store 64-bit elements, they
  must be aligned to 8 bytes, or you get a Bus Error.
- But that doesn't matter, because loading and storing 8-bit vector elements is
  just as fast as 64-bit elements, and with no alignment constraints.
- Using vectors can reduce execution time of memcpy and memcmp by 10~50% (on
  this core) and compiled code size of some functions by up to 90% (not a typo).
- Counterintuitively, where vectors shine the most is when working with small
  irregular data lengths, because the same codepath can run on 0~32 bytes
  without branching based on the length.
- Using an lmul larger than necessary has a significant performance impact.  In
  theory, a processor should be able to see that the higher lmul is
  unnecessary, and pretend that it has a lower lmul, but this processor cannot
  do that.
- Whole-register loads and stores aren't any faster than e8 loads and stores
  with maximum vl.

##### Integer instructions

- 32-bit integer multiplication has a latency of 3 cycles, with a throughput of
  1 per cycle.  64-bit mul has a latency of 5 with a through-put of 1 per 3
  cycles.  mulh by has 6-cycle latency with 1-per-4-cycle throughput.  mulh and
  mul cannot fuse; in a mulh;mul sequence the mul starts 4 cycles after the
  mulh, for a total latency of 9 cycles, during 2 of which both execution pipes
  are occupied.
- Integer division normally has a latency of 7 cycles and a throughput of 1 per
  4 cycles, independent of input data or width.  However, if the output of a
  division is used as the input to another division, it may run faster, with as
  little as 3 cycles of latency.  This system is not well understood.  div and
  rem do not seem to fuse.

##### Floating point instructions

- Floating-point addition has a latency of 4 cycles and a throughput of 2 per
  cycle for all precisions and rounding modes.
- Multiplication has 4-cycle latency for singles and halfs and 5-cycle latency
  for doubles.  All precisions have 2-per-cycle throughput.
- Floating-point division and square-root are very slow, with a data-independent
  latency of 16 for single precision, 24 for double, and 13 for half.  The
  floating point divider is not pipelined except for the first/last cycle, so
  you can divide every 15, 23, or 12 cycles.
- There is no penalty for NaN or subnormal numbers.

#### What's the fastest memcpy?

Well, it varies based on your workload, but on this processor the fastest
general-purpose memcpy I've found is something like this.
```
.align 3
.globl my_memcpy
my_memcpy:
     # See if the whole transfer fits in one v reg group
    vsetvli a4,a2,e8,m1,ta,ma
    bne a4,a2,0f
1:  vle8.v v8,(a1)
    vse8.v v8,(a0)
    ret
0:  vsetvli a4,a2,e8,m2,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m4,ta,ma
    beq a4,a2,1b
    vsetvli a4,a2,e8,m8,ta,ma
    beq a4,a2,1b
     # If it's gonna take more than 1 transfer, shorten first transfer so that
     # later ones have their dst aligned to 16 bytes
    andi a5,a0,15
    sub a4,a4,a5
    vsetvli zero,a4,e8,m8,ta,ma
    vle8.v v8,(a1)
    add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a0)
    add a3,a0,a4
3:  vsetvli a4,a2,e8,m8,ta,ma
    vle8.v v8,(a1)
    add a1,a1,a4
    sub a2,a2,a4
    vse8.v v8,(a3)
    add a3,a3,a4
    bnez a2,3b
    ret
```

On a more sophisticated processor, it might be fastest to just use m8 for
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

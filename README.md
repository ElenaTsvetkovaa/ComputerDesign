# Computer Hardware Design: Pipelined Datapath

A Verilog project that builds digital hardware from the ground up: it starts with basic logic gates and ends with a working pipelined datapath. All components are written in synthesizable Verilog, so they can be simulated or deployed on an FPGA.

## Overview

The project covers the core building blocks of a simple processor datapath, and then connects them into a pipeline.

**How the pipeline works:**

1. An input signal arrives together with a memory address.
2. The address is used to read data from memory.
3. The data is passed to the ALU, which performs the selected operation.
4. The result is written back to memory.

Every stage is synchronized to the clock, so one clock cycle moves data one stage forward. The address is stored in pipeline registers and travels together with the data through each stage. This way, when a new input enters the pipeline, the operation still in progress writes its result to its **own** address and is not affected by the new input.

## Data hazards

Because several operations are in the pipeline at the same time, a **read-after-write (RAW) hazard** can occur: a new input reads an address whose previous result has not been written back to memory yet, so the read would return stale data.

For example, with the inputs `5, 5`, the second read of address 5 happens before the first operation has finished and written its result.

**How it is resolved: address comparison + forwarding (bypassing).**
Each address travels through the pipeline registers together with its data, so the address of every in-flight operation is always known. Comparators check whether two stages work on the same address. If they do, a multiplexer takes the freshest value directly from a later stage instead of waiting for the memory:

| Hazard | Check | Forwarded value |
|---|---|---|
| Address in S1 matches the address in S4 (write in progress) | `compare_res`, registered by `comparison_keeper` | `res_keeper_out` (S5) instead of `Rdata` (memory) |
| Address in S2 matches the address in S4 | `addr_s2_to_addr_s3 == addr_s4_to_mem` | `result_reg_to_mem` instead of the memory value |
| Address in S3 matches the address in S4 | `addr_s3_to_addr_s4 == addr_s4_to_mem` | `result_reg_to_mem + 1` instead of `mem_register_to_addr + 1` |

This way the pipeline never has to stall: every operation always works with the most recent value for its own address, and the throughput stays at one input per clock cycle.


## Components

- **Basic logic gates**: AND, OR, NOT, NAND, NOR, XOR, XNOR
- **Arithmetic**: half adder and full adder
- **Sequential logic**: D flip-flops, which store a bit and pass it on at the clock edge, and registers built from them
- **Counter**: counts clock cycles
- **Memories**: synchronous and asynchronous, each with single-port and dual-port variants
- **ALU**: arithmetic and logic operations
- **Pipeline**: connects all of the above (input, memory read, ALU operation, memory write)

## Project structure

```
computer-design-2026/
├── README.md
├── .gitignore
├── gates/          # Basic logic gates + testbenches
├── adders/         # Half adder, full adder
├── memories/       # Sync/async, single-port/dual-port memories
├── pipeline/       # Pipeline: input -> read -> ALU -> write
├── alu.v           # Arithmetic Logic Unit
├── d_flip_flop.v   # D flip-flop
└── counter.v       # Counter
```

Design files are named `<name>.v` and their testbenches `tb_<name>.v`.

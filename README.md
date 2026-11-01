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

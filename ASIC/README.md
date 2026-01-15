# MSDAP – Mini Stereo Digital Audio Processor (RTL to GDSII)

This repository demonstrates a complete RTL to GDSII ASIC design flow using a custom digital design named MSDAP (Mini Stereo Digital Audio Processor). The focus of this project is on translating Verilog RTL into a physically implemented design through synthesis and physical design using industry-style CAD flows.

## What This Project Covers

- RTL design and simulation
- Logic synthesis
- Multi-mode multi-corner (MMMC) timing setup
- Floorplanning and power intent definition
- Placement, clock tree synthesis, and routing
- Generation of post-route physical outputs

## Repository Structure

ASIC/
├── CAD_Tools_scrpts_nd_tcl/
│   ├── Physical_Design/
│   │   ├── Scripts/
│   │   │   ├── floorplan.tcl
│   │   │   ├── mmmc.tcl
│   │   │   ├── par.tcl
│   │   │   ├── power_spec.cpf
│   │   │   ├── power_straps.tcl
│   │   │   └── set_dont_use.tcl
│   │   └── Outputs/
│   │       ├── top_Innovus.def
│   │       └── top_Innovus.v
│   └── Reports/
│       └── CTE_loops.rpt
└── MSDAP/
    └── Verilog Code/
        ├── top.v
        ├── tb.v
        └── supporting RTL modules

## Key Files

RTL:
- top.v – top-level RTL module
- tb.v – functional testbench

Physical Design Scripts:
- mmmc.tcl – multi-corner timing setup
- floorplan.tcl – die and core definition
- par.tcl – placement, CTS, and routing flow
- power_spec.cpf – power intent
- power_straps.tcl – power grid creation
- set_dont_use.tcl – cell usage constraints

Physical Design Outputs:
- top_Innovus.def – final post-route DEF
- top_Innovus.v – post-route netlist

## Flow Summary

1. RTL simulation
2. Logic synthesis
3. Innovus initialization with MMMC
4. Floorplanning and power planning
5. Placement, CTS, and routing
6. Generation of final DEF and netlist

## Notes

This repository keeps only essential RTL, scripts, and final outputs. Tool logs and temporary files are intentionally excluded. The project is intended for educational and demonstration purposes.

## Author

Uday Teja Bandaru

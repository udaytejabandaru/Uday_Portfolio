# ALU Design and Layout – 65 nm CMOS

## Overview
This project presents the **design, implementation, and physical realization of a 4-input sequential Arithmetic Logic Unit (ALU)** using a full custom and semi-custom ASIC flow in **65 nm CMOS technology**.

The work spans **RTL design → schematic → physical design → signoff**, with a focus on **area, power, and performance (PPA) optimization**.

**Timeline:** April 2024 – May 2024  
**Technology:** 65 nm CMOS  
**Tools:** Cadence Virtuoso, HSPICE, Innovus, Synopsys PrimeTime

---

## Design Objectives
- Design a functional multi-input ALU with sequential control
- Optimize **area and switching activity**
- Achieve **1 GHz timing closure**
- Complete **full physical signoff** (DRC, LVS, PEX)
- Evaluate **energy-delay-area efficiency**

---

## RTL Design
- Designed a **4-input sequential ALU** at the RTL level
- Performed **logic simplification and optimal resource reuse**
- Achieved approximately **30% area reduction** compared to baseline logic
- RTL structured to be synthesizable and backend-friendly

---

## Circuit & Schematic Design
- Implemented the ALU at the **schematic level in Cadence Virtuoso**
- Integrated a **switching-minimization controller** to reduce unnecessary toggling
- Optimized datapath and control logic for **lower dynamic power**
- Verified functionality using **HSPICE simulations**

---

## Physical Design Flow
- Floorplanned and implemented the design using **Cadence Innovus**
- Used a **custom standard cell library**
- Completed:
  - Placement
  - Clock routing
  - Signal routing
- Closed all physical checks:
  - **DRC (Design Rule Check)**
  - **LVS (Layout vs Schematic)**
  - **PEX (Parasitic Extraction)**

---

## Timing & Signoff
- Performed static timing analysis using **Synopsys PrimeTime**
- Achieved **1 GHz timing closure** with extracted parasitics
- Verified post-layout performance and robustness

---

## Results
- **Area Reduction:** ~30% through logic optimization
- **Target Frequency:** 1 GHz
- **AEDP (Area–Energy–Delay Product):**  
  **1.436 fJ·ps·µm²**
- Clean DRC / LVS / PEX signoff

---

## Why This Project Matters
This project demonstrates:
- End-to-end **ASIC implementation experience**
- Strong understanding of **PPA trade-offs**
- Hands-on use of **industry-standard EDA tools**
- Practical exposure to **custom and standard-cell based design**

The skills used here directly map to **ASIC RTL, Physical Design, and CAD roles**.

---

## Tools & Technologies
- **RTL & Logic:** Verilog
- **Schematic & Simulation:** Cadence Virtuoso, HSPICE
- **Physical Design:** Cadence Innovus
- **Timing Signoff:** Synopsys PrimeTime
- **Technology Node:** 65 nm CMOS

---

## Author
**Uday Teja Bandaru**  
MS in Computer Engineering  
Focus Areas: ASIC Design, Physical Design, CAD Algorithms


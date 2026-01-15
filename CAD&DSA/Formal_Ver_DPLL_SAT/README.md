# DPLL SAT Solver (Python)

## Overview
This project implements a **SAT solver using the DPLL (Davis–Putnam–Logemann–Loveland) algorithm** in Python.  
The solver takes a Boolean formula in **Conjunctive Normal Form (CNF)** as input, applies unit propagation and backtracking, and determines whether the formula is **SAT** or **UNSAT**.

This project demonstrates the core ideas behind **formal verification, constraint solving, and decision procedures** widely used in EDA tools and verification engines.

---

## What the Solver Does
In practical terms, the solver:
- Reads a CNF formula from an input file
- Identifies **unit clauses**
- Applies **unit propagation**
- Performs **decision splits** when needed
- Uses **backtracking** on conflicts
- Terminates when the CNF is empty (SAT) or a contradiction is found (UNSAT)

---

## Example Run (From Terminal)
```
CNF before solving:
CNF = (A+B+C)(!A+!B)(!B+!C)(!A+C)(B)

Units = ['B']

CNF after unit propagation = (!A+C)(!C)(!A)
Null clause found, backtracking...

Splits = 3
Unit Propagations = 6

Result: SAT

Decisions:
B = True
C = False
A = False
```

This shows:
- Unit propagation simplifying the CNF
- Conflict detection and backtracking
- Final satisfying assignment

---

## Input Format
The input is provided via a text file (e.g., `inputs.txt`) containing a CNF expression.

Example:
```
(A+B+C)(!A+!B)(!B+!C)(!A+C)(B)
```

Where:
- `+` represents logical OR
- Juxtaposed clauses represent logical AND
- `!` represents logical NOT

---

## Project Files
- `main.py` – Python implementation of the DPLL SAT solver  
- `inputs.txt` – Input CNF formula  
- `output.png` – Sample terminal execution output (screenshot)  

---

## How to Run
Make sure Python 3 is installed.

Run the solver using:
```
python3 main.py inputs.txt
```

The program prints:
- Intermediate CNF states
- Unit propagation steps
- Number of splits and propagations
- Final SAT/UNSAT result
- Variable assignments (if SAT)

---

## Why This Matters (Practical Relevance)
SAT solvers are fundamental to:
- **Formal verification**
- **Equivalence checking**
- **Constraint solving**
- **EDA tools** (logic optimization, verification, test generation)
- **Model checking and AI planning**

This project captures the **core mechanics** behind industrial SAT engines in a simplified, educational form.

---

## Concepts Used
- DPLL algorithm
- Unit propagation
- Backtracking search
- Boolean logic and CNF manipulation
- Recursive problem solving

---

## Academic Context
Developed as part of a **Formal Verification / Algorithms coursework project**.  
The focus was on understanding how SAT solvers work internally rather than using external libraries.

---

## Author
Uday Teja Bandaru  
MS in Computer Engineering  
Focus Areas: Formal Verification, CAD Algorithms, Digital Design


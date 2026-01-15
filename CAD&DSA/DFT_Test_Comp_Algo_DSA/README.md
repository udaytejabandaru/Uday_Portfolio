# Dictionary-Based Compression Algorithm (C++)

## Overview
This project implements a simple **dictionary-based data compression technique** using C++.  
The main idea is to reduce redundancy in data by identifying repeated patterns and replacing them with compact dictionary references.

This kind of compression is commonly used in **storage systems, data transmission, and EDA/DFT flows**, where repeated structures appear frequently.

---

## What the Program Does
In practical terms, the program:
- Reads input data
- Detects repeated symbols or patterns
- Stores unique patterns in a dictionary
- Replaces repeated occurrences with dictionary indices
- Produces a compressed representation of the original data

The compressed output can be reconstructed using the same dictionary.

---

## Why This Matters
Dictionary-based compression helps:
- Reduce memory and storage usage
- Improve data transfer efficiency
- Optimize test data in hardware design and verification flows

This project demonstrates the **core algorithmic concept** behind these optimizations.

---

## Project Files
- `dict.cpp` – C++ source file implementing the compression logic  
- `Makefile` – Build instructions  
- `dict.exe` – Compiled executable  
- `sample_output` – Example output for reference  
- `CE6320_project_F24.pdf` – Project description/report  

---

## How to Build
Make sure a C++ compiler (such as `g++`) is installed.

Run:
```
make
```

This will generate the executable `dict.exe`.

---

## How to Run
After building, run:
```
./dict.exe
```

The program executes the dictionary-based compression algorithm and produces output similar to the provided sample output.

---

## Technologies Used
- Language: C++
- Build system: Make
- Core concepts:
  - Data structures
  - Pattern matching
  - Compression algorithms

---

## Academic Context
This project was developed as part of **CE6320 coursework**.  
The focus was on understanding and implementing dictionary-based compression from an algorithmic and systems perspective.

---

## Author
Uday Teja Bandaru  
MS in Computer Engineering  
Interests: ASIC Design, CAD Algorithms, Digital Systems

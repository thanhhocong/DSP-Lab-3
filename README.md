# DSP Lab 3 — Discrete-Time Signal Operations

**Course:** Digital Signal Processing (Lab)  
**Student:** Ho Cong Thanh (2353097)  
**Advisor:** Nguyen Cong Thai

## Overview

This repository contains the Scilab implementations and LaTeX lab report for Lab 3, covering six fundamental discrete-time signal operations:

| Exercise | Operation      | Definition                          |
|----------|----------------|-------------------------------------|
| 1        | Time Delay     | y(n) = x(n − k), k > 0             |
| 2        | Time Advance   | y(n) = x(n + k), k > 0             |
| 3        | Folding        | y(n) = x(−n)                        |
| 4        | Addition       | y(n) = x₁(n) + x₂(n)              |
| 5        | Multiplication | y(n) = x₁(n) · x₂(n)              |
| 6        | Convolution    | y(n) = x(n) ∗ h(n)                 |

Each function correctly tracks the **origin index** of the output signal and generates a stem plot for visual verification. Four additional textbook problems (2.1, 2.2, 2.4, 2.6) are also solved.

## Requirements

- [Scilab](https://www.scilab.org/) (any recent version) to run `.sci` files.
- A LaTeX distribution (e.g. TeX Live, MiKTeX) to compile the report.

## Running the Code

Open any `.sci` file in Scilab and execute it, or run from the Scilab console:

```scilab
exec('ex1.sci', -1)
```
Then type function into Scilab console:

```scilab
[yn, yorigin] = delay ([1,  -2,  3,  6], 3, 1)
```

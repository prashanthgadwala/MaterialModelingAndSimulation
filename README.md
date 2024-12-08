# Material Modeling and Simulation - SS 2024

## Overview
This repository contains the code and documentation for a series of computer exercises focused on material modeling and simulation in 1D and 3D. The exercises cover various material behaviors including linear elasticity, elastoplasticity, viscoplasticity, and viscoelasticity. The code is implemented in Octave, an open-source alternative to MATLAB.

## Exercises

### Exercise 1: Linear Elasticity in 1D
- **Objective**: Develop an Octave code to simulate linear elastic material behavior in 1D.
- **Key Learnings**:
  - Understanding linear elasticity and stress-strain relationships.
  - Basic Octave programming and code structure.
  - Conducting numerical experiments to validate the implementation.
- **Tasks**:
  - Complete and test the `elastic.m` subroutine.
  - Implement load cases in `loadcasedefinition.m`.
  - Plot stress vs. time and stress vs. strain.

### Exercise 2: Elastoplasticity in 1D
- **Objective**: Extend the code to include rate-independent elastoplasticity models.
- **Key Learnings**:
  - Understanding different hardening models: ideal plasticity, linear isotropic hardening, and kinematic hardening.
  - Advanced Octave programming and debugging.
  - Analyzing the development of stress and internal variables over time.
- **Tasks**:
  - Complete and test subroutines for different hardening models.
  - Plot internal variables with time.

### Exercise 3: Viscoplasticity & Viscoelasticity in 1D
- **Objective**: Add material models for visco-elastoplasticity and viscoelasticity.
- **Key Learnings**:
  - Understanding viscoplasticity and viscoelasticity.
  - Implementing integration algorithms: Euler backward and convolution integral.
  - Conducting numerical experiments for different material parameters.
- **Tasks**:
  - Complete and test subroutines for viscoplasticity and viscoelasticity.
  - Compare results from different integration methods.

### Exercise 4: Elastoplasticity in 3D
- **Objective**: Introduce 3D elastoplasticity models.
- **Key Learnings**:
  - Understanding 3D elastoplasticity and tensor decomposition.
  - Handling data structures for 3D quantities.
  - Plotting contours for principal stresses and plastic strains.
- **Tasks**:
  - Complete and test subroutines for 3D elastoplasticity models.
  - Plot stress and strain contours.

## Code Structure
- `main_driver_1D.m`: Primary driver routine for 1D models.
- `main_driver_3D.m`: Primary driver routine for 3D models.
- `loadcasedefinition.m`: Defines different possible strain histories.
- `elastic.m`: Linear elastic material model.
- `idealplasti.m`: Ideal plasticity material model.
- `linisohardening.m`: Linear isotropic hardening model.
- `isokinhardening.m`: Kinematic hardening model.
- `viscoplast.m`: Elasto-viscoplasticity model.
- `standardvisco_eb.m`: Viscoelasticity model using Euler backward algorithm.
- `standardvisco_con.m`: Viscoelasticity model using convolution integral algorithm.
- `Compute_volDevSplit.m`: Computes tensor decomposition into volumetric and deviatoric parts.
- `hyperelastic.m`: Hyperelasticity model.

## Conclusion
These exercises provided a comprehensive understanding of various material behaviors and improved my programming skills in Octave. The hands-on experience with numerical experiments and code documentation has been invaluable.
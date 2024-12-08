# Material Modeling and Simulation - Computer Exercise 4

## Elastoplasticity in 3D

### Introduction
In this exercise, I extended the existing Octave code to include 3D elastoplasticity models. Unlike the previous exercises which focused on 1D models, this exercise introduces 3D models. The code computes and plots the stresses and internal variables based on prescribed strain histories.

### What I Learned
1. **Understanding 3D Elastoplasticity**:
   - Gained a deep understanding of elastoplasticity in 3D.
   - Learned about the decomposition of tensors into volumetric and deviatoric parts.

2. **Advanced Octave Programming**:
   - Enhanced my skills in Octave by implementing complex 3D material models.
   - Learned to handle data structures for 3D quantities.

3. **Code Structure and Documentation**:
   - Further understood the importance of a well-structured codebase.
   - Improved my ability to document code for better readability and maintenance.

4. **Numerical Experiments**:
   - Conducted numerical experiments to validate the implementation of 3D elastoplastic models.
   - Learned to analyze the development of stress and internal variables over time.

### Exercise Tasks
1. **Getting Familiar with the Existing Code**:
   - Reviewed the primary driver routine `main_driver_3D.m` and its subroutines.
   - Understood the data structures holding the values of different relevant quantities in 3D.

2. **Implementation**:
   - Completed the subroutine `vm_idealplasti.m`.
   - Completed the subroutine `vm_plastiisohardening.m`.
   - Added commands in `main_driver_3D.m` for plotting the contours for the principal stresses and the plastic strains.

### Code Structure
The code is organized as follows:
- `main_driver_3D.m`: The primary driver routine that calls all required subroutines.
- `loadcasedefinition.m`: Defines different possible strain histories.
- `Compute_volDevSplit.m`: Computes the decomposition of a given tensor into volumetric and deviatoric parts.
- `hyperelastic.m`: Implements hyperelasticity.
- `vm_idealplasti.m`: Defines the von Mises ideal plasticity material model.
- `vm_plastiisohardening.m`: Defines the von Mises plasticity model with isotropic hardening.

### Conclusion
This exercise provided a comprehensive understanding of elastoplasticity in 3D and further improved my programming skills in Octave. The hands-on experience with numerical experiments and code documentation has been invaluable.

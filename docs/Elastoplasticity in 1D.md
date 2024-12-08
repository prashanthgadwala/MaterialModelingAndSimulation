# Material Modeling and Simulation - Computer Exercise 2

## Elastoplasticity in 1D

### Introduction
In this exercise, I extended the existing Octave code to include material models dealing with rate-independent elastoplasticity. The code now handles new load cases and computes the development of stress and internal variables over time.

### What I Learned
1. **Understanding Elastoplasticity**:
   - Gained a deep understanding of rate-independent elastoplasticity in 1D.
   - Learned about different hardening models: ideal plasticity, linear isotropic hardening, and kinematic hardening.

2. **Advanced Octave Programming**:
   - Enhanced my skills in Octave by implementing more complex material models.
   - Learned to debug and validate code against analytical results.

3. **Code Structure and Documentation**:
   - Further understood the importance of a well-structured codebase.
   - Improved my ability to document code for better readability and maintenance.

4. **Numerical Experiments**:
   - Conducted numerical experiments to validate the implementation of elastoplastic models.
   - Learned to analyze the development of stress and internal variables over time.

### Exercise Tasks
1. **Implementation**:
   - Completed the subroutine `idealplasti.m` and tested it with analytical results from Board Exercise-3.
   - Added commands in `main_driver_1D.m` for plotting internal variables with time.
   - Completed the subroutine `linisohardening.m` and tested it with load cases 2 and 3. Compared the development of plastic strain and the hardening variable α over time.
   - Completed the subroutine `isokinhardening.m` and tested it for pure kinematic hardening with analytical results from Board Exercise-4. Observed the differences in the development of plastic strain and the hardening variable β over time.

2. **Numerical Experiments**:
   - Tested the three material models for different values of material parameters and load cases.
   - Analyzed the development of stress and internal variables over time for different material parameters: E = 196 GPa, σy = 260 MPa, K = 2100 MPa, and r ∈ {0.0, 0.5, 1.0}.

### Code Structure
The code is organized as follows:
- `main_driver_1D.m`: The primary driver routine that calls all required subroutines.
- `loadcasedefinition.m`: Defines different possible strain histories, including the new load case 5.
- `idealplasti.m`: Defines the ideal plasticity material model.
- `linisohardening.m`: Defines the linear isotropic hardening material model.
- `isokinhardening.m`: Defines the kinematic hardening material model.

### Conclusion
This exercise provided a comprehensive understanding of elastoplasticity in 1D and further improved my programming skills in Octave. The hands-on experience with numerical experiments and code documentation has been invaluable.


# Material Modeling and Simulation - Computer Exercise 1

## Linear Elasticity in 1D

### Introduction
In this exercise, I developed an Octave code for simulating material behavior in a 1D setting. The code computes and plots stresses and internal variables based on prescribed strain histories. The exercise covers different material models, including combinations of elastic, plastic, and rate-dependent responses, and various strain histories such as linearly increasing and cyclic loading.

### What I Learned
1. **Understanding Linear Elasticity**:
   - Gained a deep understanding of linear elasticity in 1D.
   - Learned how to compute stress responses for different strain inputs.

2. **Octave Programming**:
   - Improved my skills in Octave, an open-source alternative to MATLAB.
   - Learned to write and debug Octave scripts and functions.

3. **Code Structure and Documentation**:
   - Understood the importance of a well-structured codebase.
   - Learned to document code effectively for better readability and maintenance.

4. **Numerical Experiments**:
   - Conducted numerical experiments to validate the implementation.
   - Learned to interpret and analyze the results of numerical simulations.

### Exercise Tasks
1. **Getting Familiar with the Code**:
   - Reviewed the primary driver routine `main_driver_1D.m` and its subroutines.
   - Identified parts of the code that needed completion or modification.

2. **Implementation**:
   - Completed the subroutine `elastic.m` and tested it with load case 1.
   - Implemented load cases 3 and 4 in `loadcasedefinition.m`.
   - Added commands in `main_driver_1D.m` for plotting σ vs t and σ vs ϵ.

3. **Numerical Experiment**:
   - Computed stress responses for various load inputs.
   - Generated plots for ϵ vs t, σ vs t, and σ vs ϵ.

### Code Structure
The code is organized as follows:
- `main_driver_1D.m`: The primary driver routine that calls all required subroutines.
- `loadcasedefinition.m`: Defines different possible strain histories.
- `elastic.m`: Defines the linear elastic material model.

### Conclusion
This exercise provided a comprehensive understanding of linear elasticity in 1D and improved my programming skills in Octave. The hands-on experience with numerical experiments and code documentation has been invaluable.


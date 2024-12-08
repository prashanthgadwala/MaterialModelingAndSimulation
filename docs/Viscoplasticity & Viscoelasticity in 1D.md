# Material Modeling and Simulation - Computer Exercise 3

## Viscoplasticity & Viscoelasticity in 1D

### Introduction
In this exercise, I extended the existing Octave code to include material models dealing with visco-elastoplasticity and viscoelasticity. The code now handles new load cases and computes the development of stress and internal variables over time.

### What I Learned
1. **Understanding Viscoplasticity and Viscoelasticity**:
   - Gained a deep understanding of viscoplasticity and viscoelasticity in 1D.
   - Learned about different integration algorithms: Euler backward and convolution integral.

2. **Advanced Octave Programming**:
   - Enhanced my skills in Octave by implementing complex material models.
   - Learned to debug and validate code against analytical results.

3. **Code Structure and Documentation**:
   - Further understood the importance of a well-structured codebase.
   - Improved my ability to document code for better readability and maintenance.

4. **Numerical Experiments**:
   - Conducted numerical experiments to validate the implementation of viscoplastic and viscoelastic models.
   - Learned to analyze the development of stress and internal variables over time.

### Exercise Tasks
1. **Implementation**:
   - Completed the subroutine `loadcasedefinition.m` for load case 6 as described in the code documentation.
   - Completed the subroutine `viscoplast.m` which implements elasto-viscoplasticity with linear isotropic hardening and tested it with analytical results from Board Exercise-5.
   - Completed the subroutine `standardvisco_eb.m` which implements viscoelasticity using the Euler backward algorithm for integration and tested it with analytical results from Board Exercise-6.
   - Completed the subroutine `standardvisco_con.m` which implements viscoelasticity using the convolution integral-based integration algorithm. Compared the results with those obtained from the Euler backward method.

2. **Numerical Experiments**:
   - Tested the three material models for different values of material parameters and load cases.
   - Analyzed the development of stress and internal variables over time for different material parameters:
     - For viscoplasticity: E = 19,600 MPa, σy = 130 MPa, K = 9,800 MPa, and η = 50,000 MPa·s.
     - For viscoelasticity: E∞ = 0.67 MPa, E1 = 0.67 MPa, and η = 50 MPa·s.

### Code Structure
The code is organized as follows:
- `main_driver_1D.m`: The primary driver routine that calls all required subroutines.
- `loadcasedefinition.m`: Defines different possible strain histories, including the new load case 6.
- `viscoplast.m`: Defines the elasto-viscoplasticity material model with linear isotropic hardening.
- `standardvisco_eb.m`: Defines the viscoelasticity model using the Euler backward algorithm.
- `standardvisco_con.m`: Defines the viscoelasticity model using the convolution integral-based integration algorithm.

### Conclusion
This exercise provided a comprehensive understanding of viscoplasticity and viscoelasticity in 1D and further improved my programming skills in Octave. The hands-on experience with numerical experiments and code documentation has been invaluable.

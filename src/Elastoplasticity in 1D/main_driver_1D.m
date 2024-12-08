%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Driver Routine - constitutive modeling in 1D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% strain-controlled loading in 1D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
% input data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loadCase              prescribes certain eps(t)
%                       1=linearly increasing from 0 to a prescribed value
%                       2=linear increasing to epsLim, then decreasing to
%                       -epsLim and then increasing again to epsLim, all at
%                       the same rate
%                       3=cyclic tensile-compressive load with different 
%                       possible amplitudes and hence strain rates
%                       4=sinusoidal load  with different 
%                       possible amplitudes and hence strain rates
%                       5= linearly increasing and decreasing at same rate, 
%                       thus having the form eps=0-1-0-1-2-1-2-3-2-3-4 and
%                       scaled by the given factor
%                       6=linearly increasing, followed by hold time
% loadParams            parameters needed to describe the strain history for 
%                       the above mentioned loadcases
%                       loadCase=1: loadParams=[epsLim];
%                       Here, epsLim is the limit value upto which strain 
%                       changes linearly
%                       loadCase=2: loadParams=[epsLim];
%                       Here, epsLim is the limit value upto which strain 
%                       changes linearly
%                       loadCase=3: loadParams=[epsAmp_1 epsAmp_2 ... epsAmp_N];
%                       Here, epsAmp_1,...,epsAmp_n define the amplitudes for
%                       the N different cycles
%                       loadCase=4: loadParams=[epsAmp_1 epsAmp_2 ... epsAmp_N];
%                       Here, epsAmp_1,...,epsAmp_n define the amplitudes for
%                       the N different cycles
%                       loadCase=5: loadParams=[epsAmp];
%                       Here, epsAmp is the multiplying factor for the strain 
%                       peaks 
%                       loadCase=6: loadParams=[nHoldTimeSteps epsLim];
%                       Here, nHoldTimeSteps is the number of timesteps. If
%                       nHoldTimeSteps = nTimeSteps, this corresponds to an
%                       instantaneous load or the so-called step function
%                       corresponding to hold time; epsLim is the max value
%                       of strain                          
% totalTime             time in which eps is applied (defines eps-rate)
% nTimeSteps            number of time steps (should follow certain conditions
%                       as requred by different loadcases)
% matMod                material model 
%                       1=linear elasticity
%                       2=ideal plasticity
%                       3=plastic lin. iso hardening
%                       4=plastic, combined lin. iso./kin. hardening 
%                       5=viscoplasticity with lin. iso. hardening
%                       6=standard viscoelasticity, Euler backward
%                       7=standard viscoelasticity, convolution pres.
% materialParams        material parameters
%                       elastic: materialParams=[E];
%                       ideal plasticity: materialParams=[E sig_y];
%                       plasti.+iso. hardening: materialParams=[E sig_y K];
%                       plasti.+iso./kin. hardening: 
%                       materialParams=[E sig_y K r];
%                       viscoplast: materialParams=[E sig_y K eta]
%                       viscoelast: materialParams=[E_inf E_1 eta]
% further variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% deltaT                time step size 
% eps                   total strain [1 x nTimeSteps+1]
% sig                   total stress [1 x nTimeSteps+1]
% nIntVar               number of internal variables
% internalVariables     internal variables [nIntVar x nTimeSteps+1]
%                       1: elasticity: [];
%                       2: ideal plasticity: [eps^p];
%                       3: plasti+iso hardening: [eps^p alpha];
%                       4: plasti + iso & kin hardening: [eps^p alpha beta];
%                       5: viscoplast: int_n=[eps^p alpha];
%                       6: viscoelast (EB): int_n=[eps^v];
%                       7: viscoelast (conv): int_n=[h eps_n]
% eps_n1                eps at t_(n+1)
% int_n                 internal variables at t_n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loadCase=2;
loadParams= [0.0026];%[0.0026 0.0026];
matMod=3;
totalTime=5.0;
nTimeSteps=2000;
materialParams=[196000 260 6300 0.0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loadcase definition
switch loadCase
    case 3
      nCycles = length(loadParams);
      if mod(nTimeSteps,4*nCycles)~=0; 
        error("Number of time steps have to be divisible by 4*nCycles");
      end  
    case 4
      nCycles = length(loadParams);
      if mod(nTimeSteps,nCycles)~=0; 
        error("Number of time steps have to be divisible by nCycles");
      end  
    otherwise 
      if mod(nTimeSteps,10)~=0; 
        error("Number of time steps have to be divisible by ten.");
      end
end
[eps]=loadcasedefinition(loadCase,loadParams, nTimeSteps);
% initialization of vectors for stress, internal variables
deltaT = totalTime/nTimeSteps;
time=0:deltaT:totalTime;
sigma=zeros(1,nTimeSteps+1);
% number of internal variables
switch matMod
    case 1
        nIntVar=0;
    case 2
        nIntVar=1;
    case 3
        nIntVar=2;
    case 4
        nIntVar=3;
    case 5
        nIntVar=2;
    case 6
        nIntVar=1;
    case 7
        nIntVar=2;
end
% initial conditions: internal variables(t=0)=0   
internalVariables=zeros(nIntVar,nTimeSteps+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loop over timesteps (first entry in eps is '0' -> start with i=2)
for i=2:nTimeSteps+1
% integration algorithm
% current strain and internal variables from last loadstep
    eps_n1=eps(i); int_n(1:nIntVar,1)=internalVariables(:,i-1);
% different material models
    switch matMod
% elasticity
        case 1
            [sigma(i)]=elastic(materialParams,eps_n1);
% ideal plasticity
        case 2
            [sigma(i),internalVariables(:,i)]=idealplasti(materialParams,eps_n1,int_n);
% plasticity with linear hardening
        case 3 
            [sigma(i),internalVariables(:,i)]=linisohardening(materialParams,eps_n1,int_n);
% plasticity with combined iso/kin hardening
        case 4
            [sigma(i),internalVariables(:,i)]=isokinhardening(materialParams,eps_n1,int_n);
% viscoplasticity with linear hardening
        case 5 
            [sigma(i),internalVariables(:,i)]=viscoplast(materialParams,eps_n1,int_n,deltaT);
% standard viscoelasticity, Euler backward
        case 6
            [sigma(i),internalVariables(:,i)]=standardvisco_eb(materialParams,eps_n1,int_n,deltaT);
% standard viscoelasticity, convolution
        case 7
            % adapt initial conditions
            if i==2; int_n(1)=eps(1); int_n(2)=eps(1); end;
            [sigma(i),internalVariables(:,i)]=standardvisco_con(materialParams,eps_n1,int_n,deltaT);
    end        
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot results
% strain vs. time
figure(1); plot(time,eps);
hold on; grid on; xlabel('t'); ylabel('\epsilon');
% stress vs. time
figure(2); plot(time,sigma);
hold on; grid on; xlabel('t'); ylabel('\sigma');
% stress vs. strain
figure(3); plot(eps,sigma);
hold on; grid on; xlabel('\epsilon'); ylabel('\sigma');
% internal variables vs time
if matMod~=1
    for j=1: nIntVar 
        figure(j+3); plot(time,internalVariables(j,:)); hold on; 
        hold on; grid on; xlabel('t'); ylabel(strcat('internal variable-',num2str(j)));
    end
 end
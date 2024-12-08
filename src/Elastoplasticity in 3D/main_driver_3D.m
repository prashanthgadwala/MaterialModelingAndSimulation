%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Driver Routine - constitutive modeling in 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% strain-controlled loading in 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
% input data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dim                   spatial dimension of the problem.
%                       dim=3: 3D
% loadCase              prescribes certain eps(t)
%                       1=linearly increasing from 0 to a prescribed value for
%                       all the components
% loadParams            parameters needed to describe the strain history for 
%                       the above mentioned loadcases
%                       loadCase=1: loadParams=[eps11Lim eps12Lim eps13Lim;
%                       eps21Lim eps22Lim eps23Lim; 
%                       eps31Lim eps32Lim eps33Lim;];
%                       The entries of the 3x3 matrix loadParams specifies the 
%                       limit values for the individual strrain components
% loadingType           optional parameter to choose from one of the
%                       predefined load values. If set to 0, the user given
%                       value will be employed.
% totalTime             time in which eps is applied (defines eps-rate)
% nTimeSteps            number of time steps (should follow certain conditions
%                       as requred by different loadcases)
% matMod                material model 
%                       1=hyperelasticity
%                       2=von-Mises ideal elastoplasticity
%                       3=von-Mises elastoplasticity with isotropic hardening
% materialParams        material parameters
%                       1: hyperelasticity: materialParams=[lambda mu];
%                       2: ideal elastoplasticity: 
%                           materialParams=[kappa mu sigma_y];
%                       3: elastoplasticity with hardening: 
%                           materialParams=[kappa mu sigma_y K];
% further variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% deltaT                time step size 
% eps                   total strain [dim x dim x nTimeSteps+1]
% sigma                 total stress [dim x dim x nTimeSteps+1]
% epsP                  principal strains [dim x nTimeSteps+1]    
% sigmaP                principal stress [dim x nTimeSteps+1]     
% plasticEpsP           principal plastic strains [dim x nTimeSteps+1]
% nIntVar               number of internal variables
% intVars               internal variables [dim x dim x nIntVar x nTimeSteps+1]
%                       1: hyperelasticity: [];
%                       2. Von-Mises ideal elastoplasticity: [eps^p];
%                       3. Von-Mises Elastoplasticity: [eps^p alpha];
%NOTE: alpha should ideally be a scalar but it is here taken as 
% a dim x dim matrix and with alpha(1)(1) containing the value. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim=3;
loadCase=1;
loadingType=1;
loadParams=[0.02 0.0 0.0; 0.0 0.0 0.0; 0.0 0.0 0.00];
matMod=2;
totalTime=1;
nTimeSteps=200;
materialParams=[1000 500 6 500]; % [1000 500 6 500];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select pre-defined strain histories
switch loadingType
    case 1
       loadParams=[0.01 0.0 0.0; 0.0 0.0 0.0; 0.0 0.0 0.0];
    case 2
        loadParams=[0.01 0.0 0.0; 0.0 0.01 0.0; 0.0 0.0 0.0];
    case 3
        loadParams=[0.01 0.0 0.0; 0.0 0.01 0.0; 0.0 0.0 0.017];
    case 4
        loadParams=[-0.01 0.0 0.0; 0.0 0.0 0.0; 0.0 0.0 0.02];
    case 5
        loadParams=[0.01 0.0 -0.02; 0.0 0.0 0.0; -0.02 0.0 0.01];
end
loadParams;
% loadcase definition
switch loadCase
  case 1 
    if mod(nTimeSteps,10)~=0 
      error("Number of time steps have to be divisible by ten.");
    end
end
eps=loadcasedefinition(loadCase,loadParams, nTimeSteps,dim);
% initialization of datastructures for stresses and strains
deltaT = totalTime/nTimeSteps;
time=0:deltaT:totalTime;
sigma=zeros(dim,dim,nTimeSteps+1);
epsP=zeros(dim,nTimeSteps+1);
sigmaP=zeros(dim,nTimeSteps+1);
plasticEpsP=zeros(dim,nTimeSteps+1);
% number of internal variables
switch matMod
    case 1
        nIntVar=0;
    case 2
        nIntVar=1;
    case 3
        nIntVar=2;
end
% % initial conditions: internal variables(t=0)=0   
intVars=zeros(dim, dim, nIntVar,nTimeSteps+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loop over timesteps (first entry in eps is '0' -> start with i=2)
for i=2:nTimeSteps+1
% current strain and internal variable values from last loadstep    
    eps_n1=eps(:,:,i);
    intVar_n(:,:,1:nIntVar) = intVars(:,:,:,i-1);
% different material model
  switch matMod
    case 1
      [sigma(:,:,i)]=hyperelastic(materialParams,eps_n1,dim); 
      sigmaP(:,i) = eig(sigma(:,:,i));
      epsP(:,i) = eig(eps(:,:,i));
    case 2
      [sigma(:,:,i) intVars(:,:,:,i)]=vm_idealplasti(materialParams,eps_n1,intVar_n,dim);
      sigmaP(:,i) = eig(sigma(:,:,i));
      epsP(:,i) = eig(eps(:,:,i));
      plasticEpsP(:,i) = eig(intVars(:,:,1,i));
    case 3
      [sigma(:,:,i) intVars(:,:,:,i)]=vm_plastiisohardening(materialParams,eps_n1,intVar_n,dim); 
      sigmaP(:,i) = eig(sigma(:,:,i));
      epsP(:,i) = eig(eps(:,:,i));
      plasticEpsP(:,i) = eig(intVars(:,:,1,i));
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epsP;
sigmaP;
plasticEpsP;
% plot results
% principal strain contour
figure(1); 
plot3(epsP(1,:)',epsP(2,:)',epsP(3,:)');
grid on;
hold on; xlabel('\epsilon_1'); ylabel('\epsilon_2'); zlabel('\epsilon_3');
% principal stress contour
figure(2); 
plot3(sigmaP(1,:)',sigmaP(2,:)',sigmaP(3,:)', 'b');
grid on;
hold on; xlabel('\sigma_1'); ylabel('\sigma_2'); zlabel('\sigma_3');
% plot normal lines for visualization
if matMod == 2 || matMod == 3
    diagLine = sum(sigmaP)/3;
    figure(2)
    plot3(diagLine(:),diagLine(:),diagLine(:),'r');
    plot3(0:2:20,0:2:20,0:2:20,'y');
    radVals = sqrt(2/3)*materialParams(3)*[0:0.1:1];
    for k=1:length(diagLine)
       stressPoint = [sigmaP(1,k); sigmaP(2,k); sigmaP(3,k)];
       diagLinePoint = [diagLine(k); diagLine(k); diagLine(k)];
       normalVec = stressPoint - diagLinePoint;
       normalVec = normalVec/norm(normalVec);
       normalLine = [diagLine(k); diagLine(k); diagLine(k)]  + normalVec* radVals;    
       plot3(normalLine(1,:),normalLine(2,:),normalLine(3,:),'g');
    end
    grid on;
    hold on;
end
% plastic strains
if matMod == 2 || matMod == 3
    figure(3); 
    plot3(plasticEpsP(1,:)',plasticEpsP(2,:)',plasticEpsP(3,:)');
    grid on;
    hold on; xlabel('\epsilon_1^p'); ylabel('\epsilon_2^p'); zlabel('\epsilon_3^p');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uncomment below code to write resutls to file
% results to file for batch visualization
if matMod == 2 && loadingType ~=0
    outFileName = strcat('vmplasti3D-ltype-',num2str(loadingType),'_Model-',num2str(matMod),'.dat');
    outFileID=fopen(outFileName, 'w');
    plasticEps = zeros(dim,dim,nTimeSteps+1);
    plasticEps(:,:,:) = intVars(:,:,1,:);
    size(plasticEps);
    result = [time' epsP' sigmaP'];
    dlmwrite(outFileName, result, '\t');
end
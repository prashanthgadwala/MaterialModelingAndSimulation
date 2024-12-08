% 3D Von-Mises Plasticity with isotropic hardening
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input
% materialParams    material parameters, 
%                   here materialParams=[kappa mu sigma_y K];
% eps_n1            strain tensor at step n+1
% intVar_n          [eps^p alpha]
% NOTE: alpha should ideally be a scalar but it is here taken as 
% a dim x dim matrix and with alpha(1)(1) containing the value.
% dim               spatial dimension of the problem
% output
% sigma_n1          unknown stress tensor at step n+1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[sigma_n1 intVar_n1] = vm_plastiisohardening(materialParams,eps_n1,intVar_n,dim)
% initialize datastructures
sigma_n1 = zeros(dim,dim);
intVar_n1 = zeros(dim,dim,2);

size(intVar_n1);

% vol-dev split of strain
[eps_n1_vol eps_n1_dev] = Compute_volDevSplit(eps_n1,dim);

% compute trial-values
sigmaVol = 3*materialParams(1)*eps_n1_vol;
sigmaTrialDev = 2*materialParams(2)*(eps_n1_dev - intVar_n(:,:,1));
Rtrial = -materialParams(4)*intVar_n(1,1,2);
phiTrial = norm(sigmaTrialDev,'fro') - sqrt(2/3)*(materialParams(3) - Rtrial);

% do radial return if yielding occurs
if phiTrial > 0.0
  N_n1 = sigmaTrialDev/ norm(sigmaTrialDev,'fro');
  deltaLambda = phiTrial/(2*materialParams(2) + (2/3)*materialParams(4));
  intVar_n1(:,:,1) = intVar_n(:,:,1) + deltaLambda*N_n1;
  intVar_n1(1,1,2) = intVar_n(1,1,2) +  sqrt(2/3) * deltaLambda;
  sigmaDev = sigmaTrialDev - 2*materialParams(2)*deltaLambda*N_n1;
  sigma_n1 = sigmaVol + sigmaDev;
  R_n1 = -materialParams(4)*intVar_n1(1,1,2);
else
  sigmaDev = sigmaTrialDev;
  sigma_n1 = sigmaVol + sigmaDev;
  intVar_n1 =  intVar_n;
end  
end
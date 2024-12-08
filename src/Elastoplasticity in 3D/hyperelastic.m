% 3D hyperelasticity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input
% materialParams    material parameters, here materialParams=[lambda mu];
% eps_n1            strain tensor at step n+1
% dim               spatial dimension of the problem
% output
% sigma_n1          unknown stress tensor at step n+1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[sigma_n1]=hyperelastic(materialParams,eps_n1,dim)
sigma_n1=zeros(dim,dim);
sigma_n1 = materialParams(1)*trace(eps_n1)*eye(dim,dim) ...
            + 2*materialParams(2)*eps_n1;
end
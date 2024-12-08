% 1D standard viscoelasticity, Euler backward
% material parameter: materialParams=[E_inf E_1 eta_1]
% internal variables: int_n=[alpha = dashpot strain]
function[sigma_n1,int_n1]=standardvisco_eb(materialParams,eps_n1,int_n,delta_t)
tau=materialParams(3)/materialParams(2);
int_n1=delta_t/(tau+delta_t)*eps_n1+tau/(tau+delta_t)*int_n(1);
sigma_n1=materialParams(1)*eps_n1+materialParams(2)*(eps_n1-int_n1);

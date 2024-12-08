% 1D standard viscoelasticity,convolution
% material parameter: materialParams=[E_inf E_1 eta_1]
% internal variables: int_n=[h eps_n]
function[sigma_n1,int_n1]=standardvisco_con(materialParams,eps_n1,int_n,delta_t)
tau=materialParams(3)/materialParams(2);
int_n1(1)=exp(-delta_t/tau)*int_n(1)+exp(-delta_t/(2*tau))*(eps_n1-int_n(2));
sigma_n1=materialParams(1)*eps_n1+materialParams(2)*int_n1(1);
int_n1(2)=eps_n1;

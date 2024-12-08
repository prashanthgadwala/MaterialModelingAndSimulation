% 1D elasticity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input
% par               material parameter, here par=E;
% eps_n1            strain value at step n+1
% output
% sig_n1            unknown stress value at step n+1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[sig_n1]=elastic(par,eps_n1)
sig_n1=par(1)*eps_n1;

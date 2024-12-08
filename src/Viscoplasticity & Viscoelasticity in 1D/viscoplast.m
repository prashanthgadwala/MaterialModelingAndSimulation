% 1D viscoplasticity with linear isotropic hardening
% material parameter: materialParams=[E sig_y K eta]
% internal variables: int_n=[eps^vp alpha]
function[sig_n1,int_n1]=viscoplast(materialParams,eps_n1,int_n,delta_t)
% solution for rate-independent plasticity
% trial step
sig_t=materialParams(1)*(eps_n1-int_n(1));
phi_t=norm(sig_t)-(materialParams(2)+materialParams(3)*int_n(2));
% test loading conditions
if phi_t>=0
% plastic step - radial return
    deltaLambda=phi_t/(materialParams(1)+materialParams(3));
    sig_n1=sig_t-deltaLambda*materialParams(1)*sign(sig_t);
    int_n1(1)=int_n(1)+deltaLambda*sign(sig_t);
    int_n1(2)=int_n(2)+deltaLambda;
% viscoplastic regularization
    tau=materialParams(4)/materialParams(1);
    sig_n1=(sig_t+delta_t/tau*sig_n1)/(1+delta_t/tau);
    int_n1(2)=(int_n(2)+delta_t/tau*int_n1(2))/(1+delta_t/tau);
    int_n1(1)=eps_n1-sig_n1/materialParams(1);
else
% elastic step
    sig_n1=sig_t;
    int_n1(1:2)=int_n(:);
end

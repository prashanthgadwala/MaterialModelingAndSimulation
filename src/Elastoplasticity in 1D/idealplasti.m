% 1D ideal plasticity 
% material parameter: materialParams=[E sig_y]
% internal variables: int_n=[eps^p]
function[sigma_n1,int_n1]=idealplasti(materialParams,eps_n1,int_n)
% trial step
epsTrial = eps_n1 - int_n(1);
sigmaTrial=materialParams(1)*epsTrial;
phiTrial=norm(sigmaTrial)-materialParams(2);
% test loading conditions
if phiTrial>0
% plastic step - radial return
    deltaLambda=phiTrial/materialParams(1);
    sigma_n1=sigmaTrial - deltaLambda*materialParams(1)*sign(sigmaTrial);
    int_n1(1)=int_n(1,1) + deltaLambda*sign(sigmaTrial);
else
% elastic step
    sigma_n1=sigmaTrial;
    int_n1(1)=int_n(:);
end
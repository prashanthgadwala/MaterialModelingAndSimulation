% 1D elastoplasticity with linear isotropic hardening
% material parameter: materialParams = [E sig_y K]
% internal variables: int_n = [eps^p alpha]
function[sigma_n1,int_n1]=linisohardening(materialParams,eps_n1,int_n)
% trial step
epsTrial = eps_n1 - int_n(1);
sigmaTrial = materialParams(1) * epsTrial;
phiTrial = norm(sigmaTrial)-(materialParams(2)+materialParams(3)*int_n(2));
% test loading conditions
if phiTrial > 0
% plastic step - radial return
    deltaLambda = phiTrial/(materialParams(1)+materialParams(3));
    sigma_n1 = sigmaTrial - deltaLambda*materialParams(1)*sign(sigmaTrial);
    int_n1(1) = int_n(1,1) + deltaLambda*sign(sigmaTrial);
    int_n1(2) = int_n(2,1) + deltaLambda;
else
% elastic step
    sigma_n1 = sigmaTrial;
    int_n1(1:2) = int_n(:);
end
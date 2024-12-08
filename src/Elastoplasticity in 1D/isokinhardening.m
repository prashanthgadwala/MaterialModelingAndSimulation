% 1D plasticity with combined isotropic/kinematic hardening
% material parameter: materialParams = [E sig_y K r]
% internal variables: int_n = [eps^p alpha beta]
function[sigma_n1,int_n1]=isokinhardening(materialParams,eps_n1,int_n)
% trial step
sigmaTrial = materialParams(1)*(eps_n1-int_n(1));
xiTrial = sigmaTrial-(1-materialParams(4))*materialParams(3)*int_n(3);
phiTrial = norm(xiTrial)-(materialParams(2) ... 
         + materialParams(4)*materialParams(3)*int_n(2));
% test loading conditions
if phiTrial > 0
% plastic step - radial return
    deltaLambda = phiTrial/(materialParams(1)+materialParams(3));
    sigma_n1 = sigmaTrial-deltaLambda*materialParams(1)*sign(xiTrial);
    int_n1(1) = int_n(1,1)+deltaLambda*sign(xiTrial);
    int_n1(2) = int_n(2,1)+deltaLambda;
    int_n1(3) = int_n(3,1)+deltaLambda*sign(xiTrial);
else
% elastic step
    sigma_n1 = sigmaTrial;
    int_n1(1:3) = int_n(:);
end
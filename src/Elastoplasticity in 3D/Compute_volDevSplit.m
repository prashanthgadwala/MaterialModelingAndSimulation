% function to compute the volumetric deviatoric split of a dim-dimensional
% tensor
function[Avol, Adev] = Compute_volDevSplit(A,dim)
Avol = trace(A)*eye(dim,dim)/dim;
Adev = A - Avol;
end
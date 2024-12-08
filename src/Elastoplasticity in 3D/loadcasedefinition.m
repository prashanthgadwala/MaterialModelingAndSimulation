function [eps]=loadcasedefinition(loadCase,loadParams, nTimeSteps,dim)
% initializing the datastructures
eps=zeros(dim,dim,nTimeSteps+1);
 
switch loadCase
% linearly increasing to prescribed values of components
  case 1
    epsLim = loadParams;
    epsInc = epsLim/nTimeSteps;
    for i=2:nTimeSteps+1
      eps(:,:,i) = eps(:,:,i-1) + epsInc;    
    end
end  
end
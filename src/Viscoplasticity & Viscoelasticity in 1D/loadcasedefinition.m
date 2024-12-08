function [eps]=loadcasedefinition(loadCase,loadParams, nTimeSteps)
eps=zeros(1,nTimeSteps+1);
switch loadCase
% linearly increasing to prescribed value
    case 1
        epsLim = loadParams(1);
        eps(1,2:nTimeSteps+1)=...
           epsLim/nTimeSteps:epsLim/nTimeSteps:epsLim;
% linearly increasing to epsLim, then decreasing to -epsLim and then increasing 
% again to epsLim, all at the same rate
    case 2
        nTimeStepsPerUnit= nTimeSteps/5;
        startPoint= 1;
        increment = loadParams(1)/nTimeStepsPerUnit;
        eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =increment:increment:loadParams(1);
        startPoint = startPoint + nTimeStepsPerUnit;
        eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =loadParams(1)-increment:-increment:0;
        startPoint = startPoint + nTimeStepsPerUnit;
        eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =-increment:-increment:-loadParams(1);
        startPoint = startPoint + nTimeStepsPerUnit;
        eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =-loadParams(1)+increment:increment:0;
        startPoint = startPoint + nTimeStepsPerUnit;
        eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =increment:increment:loadParams(1);
% linearly increasing to i-th amplitude, then decreasing to negative amplitude
% and then increasing to 0 to complete one cycle. Similarly for other cycles.
    case 3
        nCycles = length(loadParams);
        nTimeStepsPerUnit= nTimeSteps/(4*nCycles);
        for i = 1:nCycles
          startPoint= nTimeStepsPerUnit*4*(i-1)+1;
          increment=loadParams(i)/nTimeStepsPerUnit;
          eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =increment:increment:loadParams(i);
          startPoint= startPoint + nTimeStepsPerUnit;
          eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)...
            =loadParams(i)-increment:-increment:0;
          startPoint= startPoint + nTimeStepsPerUnit;
          eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)=...
            -increment:-increment:-loadParams(i);
          startPoint= startPoint + nTimeStepsPerUnit;
          eps(1,startPoint+1:startPoint+nTimeStepsPerUnit)=...
            -loadParams(i)+increment:increment:0;
        end
% sinusoidally increasing to i-th amplitude, then decreasing to negative 
% amplitude and then increasing to 0 to complete one cycle. Similarly for other
% cycles.
    case 4
        nCycles = length(loadParams);
        nTimeStepsPerUnit= nTimeSteps/(nCycles)
        for i = 1:nCycles
          startPoint= nTimeStepsPerUnit*(i-1)+1
          for k = startPoint+1:startPoint+nTimeStepsPerUnit
            eps(1,k) = loadParams(i)*sin((k-1)/nTimeStepsPerUnit*2*pi);
          end
        end
% linearly increasing and decreasing at same rate: eps=0-1-0-1-2-1-2-3-2-3-4 
% and scaled by the given factor
    case 5
        ampFactor=loadParams(1);
        eps(1,2:nTimeSteps/10+1)=...
          ampFactor*10*1/nTimeSteps:ampFactor*10*1/nTimeSteps:ampFactor;
        eps(1,nTimeSteps/10+1:2*nTimeSteps/10+1)=...
          ampFactor:-ampFactor*10*1/nTimeSteps:0;
        eps(1,2*nTimeSteps/10+2:3*nTimeSteps/10+1)=...
          ampFactor*10*1/nTimeSteps:ampFactor*10*1/nTimeSteps:ampFactor*1;
        eps(1,3*nTimeSteps/10+1:4*nTimeSteps/10+1)=...
          ampFactor*1:ampFactor*10*1/nTimeSteps:ampFactor*2*1;
        eps(1,4*nTimeSteps/10+1:5*nTimeSteps/10+1)=...
          ampFactor*2*1:-ampFactor*10*1/nTimeSteps:ampFactor*1;
        eps(1,5*nTimeSteps/10+1:6*nTimeSteps/10+1)=...
          ampFactor*1:ampFactor*10*1/nTimeSteps:ampFactor*2*1;
        eps(1,6*nTimeSteps/10+1:7*nTimeSteps/10+1)=...
          ampFactor*2*1:ampFactor*10*1/nTimeSteps:ampFactor*3*1;
        eps(1,7*nTimeSteps/10+1:8*nTimeSteps/10+1)=...
          ampFactor*3*1:-ampFactor*10*1/nTimeSteps:ampFactor*2*1;
        eps(1,8*nTimeSteps/10+1:9*nTimeSteps/10+1)=...
          ampFactor*2*1:ampFactor*10*1/nTimeSteps:ampFactor*3*1;
        eps(1,9*nTimeSteps/10+1:nTimeSteps+1)=...
          ampFactor*3*1:ampFactor*10*1/nTimeSteps:ampFactor*4*1;
% linearly increasing + constant afterwards (for arbitrary time periods)
    case 6
        nHoldTimeSteps = loadParams(1);
        nIncTimeSteps = nTimeSteps - nHoldTimeSteps;
        if nIncTimeSteps > 0
          increment=loadParams(2)/nIncTimeSteps;
          eps(1,2:nIncTimeSteps+1)=increment:increment:loadParams(2);
          eps(nIncTimeSteps+2:nTimeSteps+1)=loadParams(2);
        else
          eps(1,1:nTimeSteps+1)=loadParams(2);
        end
end

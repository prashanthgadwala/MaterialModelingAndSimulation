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
end

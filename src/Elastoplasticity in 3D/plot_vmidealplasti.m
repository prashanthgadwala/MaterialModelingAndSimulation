clear all
close all
matMod = 2;
loadCase = 1;
loadTypesVec = [1 2 3 4 5]';
N=length(loadTypesVec);
sigmaY=6;
colors = ["k" "r" "c" "b" "m"];


% plot principal stress contours
figure(1);
hold on;
for i=1:N
    inFileName = strcat('vmplasti3D-ltype-',num2str(loadTypesVec(i)),'_Model-',num2str(matMod),'.dat');
    data=dlmread(inFileName, '\t');
    sigma = [data(:,5)'; data(:,6)'; data(:,7)'];
    pl(i) = plot3(sigma(1,:), sigma(2,:), sigma(3,:), colors(i));
    hydrostaticLine = sum(sigma)/3;
    plot3(0:2:20,0:2:20,0:2:20,'y');
    radVals = sqrt(2/3)*sigmaY*[0:0.1:1];
    for k=1:length(hydrostaticLine)
       stressPoint = [sigma(1,k); sigma(2,k); sigma(3,k)];
       hydrostaticLinePoint = [hydrostaticLine(k); hydrostaticLine(k); hydrostaticLine(k)];
       normalVec = stressPoint - hydrostaticLinePoint;
       normalVec = normalVec/norm(normalVec);
       normalLine = [hydrostaticLine(k); hydrostaticLine(k); hydrostaticLine(k)]  + normalVec* radVals;    
       plot3(normalLine(1,:),normalLine(2,:),normalLine(3,:),'g');
    end
    xlabel('\sigma_1'); ylabel('\sigma_2'); zlabel('\sigma_3');
    grid on;
end
mylegend1 = legend(pl, num2str(loadTypesVec), 'Location','best');

%% plot aligned circles
%% uncomment to visualize yield surface
% th=[0.5*pi:pi/100:1.5*pi];
% X=sqrt(2/3)*sigmaY*cos(th);
% Y=sqrt(2/3)*sigmaY*sin(th);
% initialLine=[0;0;1];
% rotatedLine = [1;1;1];
% rotationMatrix=rotateVectors3D(initialLine,rotatedLine);
% for ctr = 0:60
%     Z=ctr*ones(1,length(th));
%     cylOriginal=[X; Y; Z];
%     cylRotated = rotationMatrix * cylOriginal;
%     figure(1)
%     plot3(cylRotated(1,:),cylRotated(2,:),cylRotated(3,:),'r','HandleVisibility','off');
% end


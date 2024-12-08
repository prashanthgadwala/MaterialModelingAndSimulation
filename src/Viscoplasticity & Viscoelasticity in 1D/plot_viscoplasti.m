clc; clear all; close all;
matMod = 5;
loadCase =2;
nTimeSteps = 1000;
etaVec = [10 2000 10000 25000]';
%etaVec(1:4,1) = 50000;
%totalTimeVec = [1 10 20 50]';
totalTimeVec(1:4,1) = 10;
timeRateVec = 0.052 ./ totalTimeVec;
N=length(etaVec);
colors = ["k" "r" "g" "b"];

% plot eps_p vs t
figure;
hold on;
for i=1:N
  inFileName = strcat('viscoplasti_eta-',num2str(etaVec(i)),  '_totalTime-',num2str(totalTimeVec(i)),'_lc-',num2str(loadCase),'_nTimesTeps-', num2str(nTimeSteps), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,2), (colors(i)));
  xlabel('t');
  ylabel('\epsilon');
end
mylegend0 = legend(pl, num2str(etaVec), 'Location','southEast');


% plot sigma vs t
figure;
hold on;
for i=1:N
  inFileName = strcat('viscoplasti_eta-',num2str(etaVec(i)),  '_totalTime-',num2str(totalTimeVec(i)), '_lc-',num2str(loadCase),'_nTimesTeps-', num2str(nTimeSteps), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,3), (colors(i)));
  xlabel('t');
  ylabel('\sigma');
end
mylegend1 = legend(pl, num2str(etaVec), 'Location','southEast');

% plot sigma vs eps
figure;
hold on;
for i=1:N
  inFileName = strcat('viscoplasti_eta-',num2str(etaVec(i)),  '_totalTime-',num2str(totalTimeVec(i)), '_lc-',num2str(loadCase),'_nTimesTeps-', num2str(nTimeSteps), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,2), data(:,3), (colors(i)));
  xlabel('\epsilon');
  ylabel('\sigma');
end
mylegend2 = legend(pl, num2str(etaVec), 'Location','northWest');

% plot eps_p vs t
figure;
hold on;
for i=1:N
  inFileName = strcat('viscoplasti_eta-',num2str(etaVec(i)),  '_totalTime-',num2str(totalTimeVec(i)),'_lc-',num2str(loadCase),'_nTimesTeps-', num2str(nTimeSteps), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,4), (colors(i)));
  xlabel('t');
  ylabel('\epsilon^p');
end
mylegend3 = legend(pl, num2str(etaVec), 'Location','best');

% plot alpha vs t
figure;
hold on;
for i=1:N
  inFileName = strcat('viscoplasti_eta-',num2str(etaVec(i)),  '_totalTime-',num2str(totalTimeVec(i)), '_lc-',num2str(loadCase),'_nTimesTeps-', num2str(nTimeSteps), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,5), (colors(i)));
  xlabel('t');
  ylabel('\alpha');
end
mylegend4 = legend(pl, num2str(etaVec), 'Location','southEast');
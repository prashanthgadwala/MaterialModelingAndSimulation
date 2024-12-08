matMod = 7;
loadCase = 6;
nTimeStepVec = [1000 100 50 20 10]';
% nTimeStepVec(1:5,1) = 1000;
N=length(nTimeStepVec);
% totalTimeVec = [10 100 200 500 1000]';
totalTimeVec(1:5,1) = 100;
colors = ["k" "r" "g" "b" "m"];
% totalTime = 1000;

% plot eps vs time
figure;
 hold on;
for i=1:N
  inFileName = strcat('viscoelasti_totalTime-',num2str(totalTimeVec(i)), '_nTimesTeps-', num2str(nTimeStepVec(i)), '_lc-',num2str(loadCase), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,2), (colors(i)));
  xlabel('t');
  ylabel('\epsilon');
end
mylegend1 = legend(pl, num2str(nTimeStepVec), 'Location','best');


% plot sigma vs time
figure;
 hold on;
for i=1:N
  inFileName = strcat('viscoelasti_totalTime-',num2str(totalTimeVec(i)), '_nTimesTeps-', num2str(nTimeStepVec(i)), '_lc-',num2str(loadCase), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,1), data(:,3), (colors(i)));
  xlabel('t');
  ylabel('\sigma');
end
mylegend2 = legend(pl, num2str(nTimeStepVec), 'Location','best');

% plot sigma vs time
figure;
 hold on;
for i=1:N
  inFileName = strcat('viscoelasti_totalTime-',num2str(totalTimeVec(i)), '_nTimesTeps-', num2str(nTimeStepVec(i)), '_lc-',num2str(loadCase), '_Model-',num2str(matMod),'.dat');
  data = dlmread(inFileName, '\t');
  pl(i) = plot(data(:,2), data(:,3), (colors(i)));
  xlabel('\epsilon');
  ylabel('\sigma');
end
mylegend3 = legend(pl, num2str(nTimeStepVec), 'Location','best');

% 183.605 Machine Learning for Visual Computing
% Assignment 1
% Jeanny Pan, Stefan Sietzen, Lydia-Fani Simantiraki
% Part 1.1.2 batch

%% Preprocess 

% read the data
fileID = fopen('../../perceptrondata.csv','r');
formatSpec = '%f %f %f';
N = 200; % number of points
mySize = [3 N];
data = fscanf(fileID, formatSpec, mySize);

% separate data into classes according to their target values
col_idx = (data(3,:)>0);
class1 = data([1:2], col_idx);
class2 = data([1:2], ~col_idx);

% transform data
class1t = class1.^2;
class2t = class2.^2;

%% Plot data

% left figure contains original data
subplot(1, 2, 1);
scatter(class1(1,:), class1(2,:), 'filled', 'b');
hold on
scatter(class2(1,:), class2(2,:), 'filled', 'r');

% right figure contains transformed data
subplot(1, 2, 2);
scatter(class1t(1,:), class1t(2,:), 'filled', 'b');
hold on
scatter(class2t(1,:), class2t(2,:), 'filled', 'r');

%% Prepare data for perceptron training

% transform data
X = data([1,2],:).^2;

% augment
X = [ones(1,200);X];
t = data(3,:)';

%% Run 1 out of 686 iterations of batch perceptron training

% After testing we computed that the batch version
% needs 686 iterations to converge.

% run one iteration of batch version
w = percTrain(X, t, 1, false);

% plot line in transformed space
plot( [0, -w(1)/w(2)], [-w(1)/w(3), 0], ':', 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, ':', 'LineWidth', 2);

%% Run 343 out of 686 iterations of batch perceptron training

% run 343 iterations
w = percTrain(X, t, 343, false);

% plot line in transformed space
subplot(1, 2, 2);
plot( [0, -w(1)/w(2)], [-w(1)/w(3), 0], ':', 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, ':', 'LineWidth', 2);

%% Run 686 out of 686 iterations of batch perceptron training

% run until convergence
w = percTrain(X, t, 1000, false);

% plot line in transformed space
subplot(1, 2, 2);
plot( [0, -w(1)/w(2)], [-w(1)/w(3), 0], 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, 'LineWidth', 2);

%% Make plots nice

subplot(1, 2, 1);
axis('equal')
axis('tight')
title('Original Data')
xlabel('x_1')
ylabel('x_2')
lgn = legend('target vector 1', 'target vector -1', 'one iteration', '343 iterations', 'final result');
lgn.Location = 'northwest';

subplot(1, 2, 2);
axis('equal')
axis('tight')
title('Transformed Data')
xlabel('x_1')
ylabel('x_2')
lgn2 = legend('target vector 1', 'target vector -1', 'one iteration', '343 iterations', 'final result');
lgn2.Location = 'northwest';
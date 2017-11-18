% 183.605 Machine Learning for Visual Computing
% Assignment 1
% Jennie Pen, Stefan Sietzen, Lydia-Fani Simantiraki
% Part 1.1.2

%% Preprocess 

% read the data
fileID = fopen('../perceptrondata.csv','r');
formatSpec = '%f %f %f';
N = 200; % number of points
mySize = [3 N];
data = fscanf(fileID, formatSpec, mySize);

% separate data into classes according to their target values
col_idx = (data(3,:)>0);
class1 = data(:, col_idx);
class2 = data(:, ~col_idx);

% transform data
class1t = class1([1,2],:).^2;
class2t = class2([1,2],:).^2;

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
t = t * [1 1 1];
Xt = X.*t';

% bring negative data to positive side
gamma = 1;
w = zeros(3,1); % initialize hyperplane

%% Run 1 out of 7 iterations of online perceptron training

% After testing we computed that the online version
% needs 7 iterations to converge.

% run one iteration of online version
for i=1:N
    if w'*Xt(:,i) <= 0
        w = w + gamma*Xt(:,i);     
    end
end

% plot line in transformed space
plot( [0, -w(1)/w(3)], [-w(1)/w(2), 0], ':', 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, ':', 'LineWidth', 2);

%% Run 3 out of 7 iterations of online perceptron training

% 2 more iterations for a total of 3
for j=1:2
    for i=1:N
        if w'*Xt(:,i) <= 0
            w = w + gamma*Xt(:,i);     
        end
    end
end

% plot line in transformed space
subplot(1, 2, 2);
plot( [0, -w(1)/w(3)], [-w(1)/w(2), 0], ':', 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, ':', 'LineWidth', 2);

%% Run 7 out of 7 iterations of online perceptron training

% 4 more iterations for a total of 7 needed to converge
for j=1:4
    for i=1:N
        if w'*Xt(:,i) <= 0
            w = w + gamma*Xt(:,i);     
        end
    end
end

% plot line in transformed space
subplot(1, 2, 2);
plot( [0, -w(1)/w(3)], [-w(1)/w(2), 0], 'LineWidth', 2 );

% plot ellipse in original space
subplot(1, 2, 1);
te = linspace(0,2*pi);
Xe = sqrt(-w(1)/w(2))*cos(te);
Ye = sqrt(-w(1)/w(3))*sin(te);
plot(Xe, Ye, 'LineWidth', 2);

%% Make plots nice

subplot(1, 2, 1);
axis('equal')
axis([-0.65 0.65 -0.65 0.65])
title('Original Data')
xlabel('x_1')
ylabel('x_2')
legend('target vector 1', 'target vector -1', 'one iteration', 'three iterations', 'final result')

subplot(1, 2, 2);
axis('equal')
axis([0 0.25 0 0.25])
title('Transformed Data')
xlabel('x_1')
ylabel('x_2')
legend('target vector 1', 'target vector -1', 'one iteration', 'three iterations', 'final result')
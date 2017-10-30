% 183.605 Machine Learning for Visual Computing
% Assignment 1
% names
% Part 1.1.1

% read the data
fileID = fopen('perceptrondata.csv','r');
formatSpec = '%f %f %f';
size = [3 200];
data = fscanf(fileID, formatSpec, size);

% separate vectors by target values
col_idx = (data(3,:)>0);
class1 = data(:, col_idx);
class2 = data(:, ~col_idx);

% plot classes
subplot(1, 2, 1);

scatter(class1(1,:), class1(2,:), 'filled', 'b');
hold on
scatter(class2(1,:), class2(2,:), 'filled', 'r');

axis('equal')
axis('tight')
title('Initial Data')
xlabel('x_1')
ylabel('x_2')
legend('target vector 1', 'target vector -1')

% transform data and make new plot
class1t = class1([1,2],:).^2;
class2t = class2([1,2],:).^2;

subplot(1, 2, 2);

scatter(class1t(1,:), class1t(2,:), 'filled', 'b');
hold on
scatter(class2t(1,:), class2t(2,:), 'filled', 'r');

axis('equal')
axis('tight')
title('Transformed Data')
xlabel('x_1')
ylabel('x_2')
legend('target vector 1', 'target vector -1')


hold off
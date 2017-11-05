% 183.605 Machine Learning for Visual Computing
% Assignment 1
% names
% Part 2

%generate data

groupN = 7;
d = 2;
iterations = 10000;

x_values = linspace(0, 5, 51);
y_values = 2.*x_values.^2 - 7.*x_values + 1;

data = [x_values' y_values'];


training_data = data(1:8:end, :);
norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
target_data = training_data(:, 2) + norm_rnd;

computeError(training_data, [1 -7 2], target_data, d);

plot(x_values, y_values);
plot(training_data);

w = zeros(1, d + 1);

for i = 1:iterations
    norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
    target_data = training_data(:, 2) + norm_rnd;
    w = gradientUpdate(training_data, target_data, w, d, 0.001)
    e = computeError(training_data, w, training_data(:, 2), d)
    wdiff = sum(abs([1 -7 2] - w))
end

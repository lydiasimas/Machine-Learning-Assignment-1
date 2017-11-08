% 183.605 Machine Learning for Visual Computing
% Assignment 1
% names
% Part 2

%generate data

groupN = 7;
d = 2;
iterations = 10000;

RUN_GD = 1;
RUN_CF = 0;

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

norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
target_data = training_data(:, 2) + norm_rnd;

it_count = 0
if(RUN_GD == 1)
    %gradient descent
    last_e = 0;
    for i = 1:iterations
        w = gradientUpdate(training_data, target_data, w, d, 0.001);
        e = computeError(training_data, w, training_data(:, 2), d)
        ediff = e-last_e
        last_e = e;
        wdiff = sum(abs([1 -7 2] - w));
        if(abs(ediff) < 0.01)
            break;
        end
        it_count = it_count + 1;
    end
    
end

w
it_count

if(RUN_CF == 1)
    cf_trainingdata = zeros([2000*size(training_data, 1), 2]);
    size(cf_trainingdata);
    %closed form
    for i=1:2000
        start = (i-1)*7+1;
        norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
        cf_trainingdata(start:start+6, 1) = training_data(mod(i-1, 7)+1, 1);
        cf_trainingdata(start:start+6, 2) = training_data(mod(i-1, 7)+1, 2) + norm_rnd;
    end

    scatter(cf_trainingdata(:, 1), cf_trainingdata(:, 2));
    
    w = closedForm(cf_trainingdata, d)
end

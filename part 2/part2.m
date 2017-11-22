% 183.605 Machine Learning for Visual Computing
% Assignment 1
% names
% Part 2

%generate data

groupN = 7;
d = 2;
iterations = 10000;

RUN_22 = 0;
RUN_23 = 1;

x_values = linspace(0, 5, 51);
y_values = 2.*x_values.^2 - 7.*x_values + 1;

data = [x_values' y_values'];


training_data = data(1:8:end, :);
norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
target_data = training_data(:, 2) + norm_rnd;
X = training_data(:, 1);

computeError(X, [1 -7 2], target_data, d);

figure
plot(x_values, y_values,'green');
hold on
scatter(training_data(:, 1),target_data(:,1),'blue');
plot(training_data(:,1),training_data(:,2),'blue');

w = zeros(1, d + 1);

it_count = 0;
if(RUN_22 == 1)
    %gradient descent
    last_e = 0;
    for i = 1:iterations
        w = gradientUpdate(X, target_data, w, d, 0.001);
        e = computeError(X, w, target_data, d)
        ediff = e-last_e
        last_e = e;
        wdiff = sum(abs([1 -7 2] - w));
        if(abs(ediff) < 0.01)
            break;
        end
        it_count = it_count + 1;
    end
    


w_grad_desc = w
it_count

w_closed_form = closedForm(X, target_data, d)
e_closed_form = computeError(X, w_closed_form', target_data, d)

end

%2.3

if(RUN_23 == 1)
    testObs = data(44, :)
    mseResult = zeros(9, 2);
    bias2Result = zeros(9, 2);
    varResult = zeros(9, 2);

    for d=0:8
        w_closed_form = zeros(2000, d+1);

        for i=1:2000
            norm_rnd = normrnd(0, 4, size(training_data, 1), 1);
            target_data = training_data(:, 2) + norm_rnd;
            w_closed_form(i, :) = closedForm(training_data(:, 1), target_data, d);
        end
        mseResult(d+1, 1) = d;
        mseResult(d+1, 2) = mserr(testObs(1), w_closed_form, testObs(2), d);       
        bias2Result(d+1, 1) = d;
        bias2Result(d+1, 2) = bias2(testObs(1), w_closed_form, testObs(2), d);
        varResult(d+1, 1) = d;
        varResult(d+1, 2) = variance(testObs(1), w_closed_form, testObs(2), d);
    end
    mseResult
    bias2Result
    varResult
    figure
    plot(mseResult(:, 1), mseResult(:, 2));
    hold on
    plot(bias2Result(:, 1), bias2Result(:, 2));
    plot(varResult(:, 1), varResult(:, 2));
    legend('mse','bias2', 'var')
    hold off
end

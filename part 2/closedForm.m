function w = closedForm(training_data, d)
    w = 0;
    X = training_data(:, 1) .^ linspace(0, 2, d+1);
    t = training_data(:, 2);
    X = X';
    t = t';
    w = (X*X')^(-1)*X*t';
end
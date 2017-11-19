function w = closedForm(X, t, d)
    X = X .^ linspace(0, d, d+1);
    X = X';
    t = t';
    w = (X*X')^(-1)*X*t';
end
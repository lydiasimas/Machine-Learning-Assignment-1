function error = mse(X, w, t, d)
    x = X(:, 1) .^ linspace(0, 2, d+1);
    o = x * w';
    error = 1/size(X, 1) * sum((t-o).^2);
end
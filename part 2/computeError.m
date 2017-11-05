function error = computeError(X, w, t, d)
    x = X(:, 1) .^ linspace(0, 2, d+1);
    o = x * w';
    error = 0.5 * sum((t-o).^2);
end
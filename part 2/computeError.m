function error = computeError(X, w, t, d)
    x = X .^ linspace(0, d, d+1);
    o = x * w';
    error = 0.5 * sum((t-o).^2);
end
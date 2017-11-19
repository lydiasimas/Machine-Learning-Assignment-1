function error = mserr(X, w, t, d)
    x = X(:, 1) .^ linspace(0, d, d+1);
    o = x * w';
    error = mean(((t-o).^2));
end
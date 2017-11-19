function out = var(X, w, t, d)
    x = X(:, 1) .^ linspace(0, d, d+1);
    o = x * w';
    e_o = mean(o);
    out = mean((e_o - o).^2);
end
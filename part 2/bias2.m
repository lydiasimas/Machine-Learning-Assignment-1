function bias = bias2(X, w, t, d)
    x = X(:, 1) .^ linspace(0, d, d+1);
    o = x * w';
    e_o = mean(o);
    bias = (e_o - t)^2;
end
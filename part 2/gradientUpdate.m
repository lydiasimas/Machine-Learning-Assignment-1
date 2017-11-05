function w = gradientUpdate(X, t, w, d, lr)
    x = X(:, 1) .^ linspace(0, 2, d+1);
    o = x * w';
    d = sum(lr*(t - o) .* x);
    
    w = w + d;

end
function w = gradientUpdate(X, t, w, d, lr, online)
if online
    for i = 1:size(X, 1)
        x = X(i, :) .^ linspace(0, d, d+1);
        o = x * w';
        delta = lr*(t(i, :) - o) .* x;

        w = w + delta;
    
    end
else

    x = X .^ linspace(0, d, d+1);
    o = x * w';
    delta = sum(lr*(t - o) .* x);
    
    w = w + delta;
    
end

end
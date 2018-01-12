function [y_new] = rbf_predictSVM(alpha,X,t,x_new, sigma)
    n = size(alpha, 1);
    K = zeros(n);
    d = 0;
    for i=1:n
        d = d + alpha(i)*t(i)*rbfkernel(X(i,:), x_new, sigma);
    end
    
    if d>0
        y_new = 1;
    else
        y_new = -1;
    end
    y_new = d;
end
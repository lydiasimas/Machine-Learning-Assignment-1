function [y_new] = predictSVM(alpha,X,t,x_new)
    w = sum(alpha.*t.*X, 1);
    
    %for w0 calculation
    s_inds = alpha > 0.0001;
    s_vectors = X(s_inds, :);
    s_targets = t(s_inds);
    
    %for w0 calculation
    sv = s_vectors(1, :);
    st = s_targets(1);
    
    w0 = st - sum(alpha.*t.*(X*sv'), 1);
    
    y_new = w*x_new' + w0;
end
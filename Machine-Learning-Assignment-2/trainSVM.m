function [alpha, w0, s_vectors] = trainSVM(X,t)
    N = size(X, 1);
    M = size(X, 2);
    H = zeros(N);
    f = ones(N, 1);
    A = [];
    b = [];
    Aeq = t';
    beq = 0;
    lb = zeros(N, 1);
    ub = Inf(N, 1);
    
    for i=1:N
       for j=1:N
          H(i, j) = t(i)*t(j)*(X(i, :)*X(j, :)');
       end
    end
    alpha = quadprog(H, -f, A, b, Aeq, beq, lb, ub);
    s_inds = alpha > 0.0001;
    s_vectors = X(s_inds, :);
    s_targets = t(s_inds);
    
    %for w0 calculation
    sv = s_vectors(1, :);
    st = s_targets(1);
    
    w0 = st - sum(alpha.*t.*(X*sv'), 1)
end
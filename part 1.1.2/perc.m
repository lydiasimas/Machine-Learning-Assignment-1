function y = perc(w, X)
%PERC simulates a perceptron
%   The first argument is the weight vector w and the second argument is a
%   matrix with input vectors in its columns X. Both use homogeneous
%   coordinates. The output y is a binary vector with class labels 1 if the
%   vector is on the positive side of w, -1 if it is on the negative, or 0
%   if the point lies on the hyperplane.

y = w'*X;
for i = 1:N
    
    if y(i) > 0
        y(i) = 1
    elseif y(i) < 0
        y(i) = -1
    end
    
end

end


% 183.605 Machine Learning for Visual Computing
% Assignment 1
% Jennie Pen, Stefan Sietzen, Lydia-Fani Simantiraki
% Part 1.1.2

function w = percTrain(X, t, maxIts, online) 
%   Perceptron Training Algorithm

flag = 1;
[d,N] = size(X);
t = t * [1 1 1];
Xt = X.*t';
gamma = 1;
w = zeros(d,1);

if online == true
    % online version
    count=0;
    while flag ~= 0
        
        flag = 0;
        
        for i=1:N
            if j <= 0
                flag = 1; % found misclassified vector
                w = w + gamma*Xt(:,i);     
            end
        end
        count=count+1;
    end
    count
else
    % batch version
    count = 0;
    
    while flag ~= 0 && count < maxIts
        flag = 0;
        count = count + 1;
        Dw = zeros(d,1);
        for i=1:N
            if w'*Xt(:,i) <= 0
                flag = 1;
                Dw = Dw + Xt(:,i);
            end
        end
        w = w + gamma*Dw;
    end
    count
end
function w = percTrain(X, t, maxIts, online) 
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

flag = 1;
[d,N] = size(X);
t = t * [1 1 1];
Xt = X.*t';
size(X)
size(t')
size(Xt)
pause(3)
gamma = 1;
w = zeros(d,1);

if online == true
    % online version
    
    while flag ~= 0
        
        flag = 0;
        
        for i=1:N
            if w'*Xt(:,i) <= 0
                flag = 1; % found misclassified vector
                w = w + gamma*Xt(:,i);     
            end
        end
        
    end
    
else
    % batch version
    count = 0;
    
    while flag ~= 0 && count < maxIts
        disp('hello');
        flag = 0;
        count = count + 1;
        Dw = zeros(d,1);
        for i=1:N
            if w'*Xt(:,i) <= 0
                disp('bye');
                flag = 1;
                Dw = Dw + Xt(:,i);
            end
        end
        w = w + gamma*Dw;
    end
    count
end


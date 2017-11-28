clear

%% Preprocess 

% read the data
fileID = fopen('../../perceptrondata.csv','r');
formatSpec = '%f %f %f';
N = 200; % number of points
mySize = [3 N];
data = fscanf(fileID, formatSpec, mySize);

%% Prepare data for perceptron training

% transform data
X = data([1,2],:).^2;

% augment
X = [ones(1,200);X];
t = data(3,:)';
t = t * [1 1 1];
Xt = X.*t';

%% Batch version
%%{
gamma = [1:10]
count = zeros(1, size(gamma,2));
for j=1:size(gamma, 2)
    %subplot(1, size(gamma, 2), j)
    hold on
    %disp(j)
    g = gamma(j)
    flag = 1;
    w = zeros(3,1); % initialize hyperplane
    %while flag ~= 0 && count < maxIts
    while flag ~= 0
        flag = 0;
        Dw = zeros(3,1);
        for i=1:N
            if w'*Xt(:,i) <= 0
                flag = 1;
                Dw = Dw + Xt(:,i);
            end
        end
        w = w + g*Dw;
        %plot( [0, -w(1)/w(2)], [-w(1)/w(3), 0], ':' );
        count(j) = count(j) + 1;
    end
    count
end

plot(gamma, count)
%%}

%% Online version
%{
gamma = [1:1:10]
count = zeros(1, size(gamma,2));
for j=1:size(gamma, 2)
    %disp(j)
    g = gamma(j)
    flag = 1;
    w = zeros(3,1); % initialize hyperplane
    %while flag ~= 0 && count < maxIts
    while flag ~= 0
        
        flag = 0;
        
        for i=1:N
            if w'*Xt(:,i) <= 0
                flag = 1; % found misclassified vector
                w = w + g*Xt(:,i);     
            end
        end
        count(j) = count(j) + 1;
    end
end
plot(gamma, count)
%}
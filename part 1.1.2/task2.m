% read the data
fileID = fopen('../perceptrondata.csv','r');
formatSpec = '%f %f %f';
size = [3 200];
data = fscanf(fileID, formatSpec, size);

col_idx = (data(3,:)>0);
class1 = data(:, col_idx);
class2 = data(:, ~col_idx);
class1t = class1([1,2],:).^2;
class2t = class2([1,2],:).^2;

scatter(class1t(1,:), class1t(2,:), 'filled', 'b');
hold on
scatter(class2t(1,:), class2t(2,:), 'filled', 'r');


X = data([1,2],:).^2;
X = [ones(1,200);X];
t = data(3,:)';

w=percTrain(X,t,1000,1)

w = w/norm(w)

plot( [0, -w(1)/w(2)], [-w(1)/w(3), 0] )
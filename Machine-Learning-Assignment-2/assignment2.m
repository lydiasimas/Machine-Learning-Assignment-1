N=10;

rng(10);

train_set = zeros(N, 3);
train_set(:, 1:2) = rand(N, 2);

for i=1:N
    a = -train_set(:, 1) - train_set(:,2) + 1.0;
    if -train_set(i, 1) - train_set(i,2) + 1.2 < 0
        train_set(i, 3) = 1;
    else
        train_set(i, 3) = -1;
    end
    
end

scatter(train_set(:, 1), train_set(:, 2),[], train_set(:, 3), 'filled');
hold on;

[alpha, w0] = trainSVM(train_set(:, 1:2), train_set(:,3));

w = sum(alpha.*train_set(:, 3).*train_set(:, 1:2), 1);

w = [w0 w];
w = - w ./ w(3);

x = linspace(0, 1, 10);
y = x*w(2) + w(1);
plot(x, y);

k=rbfkernel(train_set(:, 1), train_set(:, 2),1);
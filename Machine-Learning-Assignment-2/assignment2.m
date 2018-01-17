N=20;

rng(10);

A11 = 1;
A12 = 1;


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

if A11
    scatter(train_set(:, 1), train_set(:, 2),[], train_set(:, 3), 'filled');
    hold on;

    sigma = .2

    [alpha, w0, s_vectors] = trainSVM(train_set(:, 1:2), train_set(:,3));

    %visualize support vectors
    scatter(s_vectors(:, 1), s_vectors(:, 2), 100, 'o');

    w = sum(alpha.*train_set(:, 3).*train_set(:, 1:2), 1);

    w = [w0 w];
    w = - w ./ w(3);

    x = linspace(0, 1, 2);
    y = x*w(2) + w(1);
    plot(x, y);

    new_vec = [.6, .6];
    new_vec2 = [.3, .6];
    

    y_new = predictSVM(alpha,train_set(:, 1:2), train_set(:,3),new_vec);
    y_new = sign(y_new);
    scatter(new_vec(1), new_vec(2), [], y_new, 'filled');
    scatter(new_vec(1), new_vec(2), 100, 'o');
    scatter(new_vec(1), new_vec(2), 200, 'o');
    
    y_new2 = predictSVM(alpha,train_set(:, 1:2), train_set(:,3),new_vec2);
    y_new2 = sign(y_new2);
    scatter(new_vec2(1), new_vec2(2), [], y_new2, 'filled');
    scatter(new_vec2(1), new_vec2(2), 100, 'o');
    scatter(new_vec2(1), new_vec2(2), 200, 'o');


    % plot kernel decision boundary

    % Make classification predictions over a grid of values
    x1plot = linspace(min(train_set(:,1)), max(train_set(:,1)), 50)';
    x2plot = linspace(min(train_set(:,2)), max(train_set(:,2)), 50)';
    [X1, X2] = meshgrid(x1plot, x2plot);
    vals = zeros(size(X1));
    for i = 1:size(X1, 2)
       this_X = [X1(:, i), X2(:, i)];
       vals(:, i) = predictSVM(alpha,train_set(:, 1:2), train_set(:,3),this_X);
    end
    vals;

    % Plot the SVM boundary
    contour(X1, X2, vals, [0 0], 'Color', 'b');
    hold off;
    waitforbuttonpress;
end

if A12
    %non linearly separable data

    mu1 = ones(N/2, 1)*[0.35, 0.15];
    mu2 = ones(N/2, 1)*[0.75, 0.75];
    mu3 = ones(N/2, 1)*[0.0, 0.0];
    mu4 = ones(N/2, 1)*[0.0, 0.6];

    blob1 = normrnd(mu1, 0.15, N/2, 2);
    blob2 = normrnd(mu2, 0.1, N/2, 2);
    blob3 = normrnd(mu3, 0.1, N/2, 2);
    blob4 = normrnd(mu4, 0.1, N/2, 2);

    blob1 = [blob1, ones(N/2, 1)];
    blob2 = [blob2, ones(N/2, 1)*-1];
    blob3 = [blob3, ones(N/2, 1)*-1];
    blob4 = [blob4, ones(N/2, 1)*-1];

    rbf_training = [blob1; blob2; blob3; blob4];

    scatter(rbf_training(:, 1), rbf_training(:, 2), [], rbf_training(:, 3), 'filled');
    hold on;
    
    C = 0.5;
    [alpha, w0, s_vectors] = rbf_trainSVM_soft(rbf_training(:, 1:2), rbf_training(:,3), sigma, C);

    % Make classification predictions over a grid of values
    x1plot = linspace(min(rbf_training(:,1)), max(rbf_training(:,1)), 50)';
    x2plot = linspace(min(rbf_training(:,2)), max(rbf_training(:,2)), 50)';
    [X1, X2] = meshgrid(x1plot, x2plot);

    vals = zeros(size(X1));
    for i = 1:size(X1, 1)
        for j = 1:size(X2, 2)
            this_X = [X1(i, j), X2(i, j)];
            pred = rbf_predictSVM(alpha,rbf_training(:, 1:2), rbf_training(:,3),this_X, sigma);
            vals(i, j) = pred;
        end
    end

    % Plot the SVM boundary
    contour(X1, X2, vals, [0, 0], 'Color', 'b');
    
    %visualize support vectors and sigma
    scatter(s_vectors(:, 1), s_vectors(:, 2), 100, 'o');
    %visualize support vectors
    scatter(s_vectors(:, 1), s_vectors(:, 2), 100, 'o');
    
    % plot support vector + sigma, disabled because of cluttering
    for i=1:size(s_vectors, 1)
        sv = s_vectors(i, :);
        
        %circle(sv(1), sv(2), sigma);
    end
    hold off;
end


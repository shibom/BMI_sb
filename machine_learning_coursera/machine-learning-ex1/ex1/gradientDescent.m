function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
    
    grad = zeros(size(theta));
    grad1 = 0; grad2 = 0;
    for i=1:m
        grad1 = grad1 + ((theta(1,1).*X(i,1) + theta(2,1).*X(i,2)) - y(i,1)).*X(i,1);
        grad2 = grad2 + ((theta(1,1).*X(i,1) + theta(2,1).*X(i,2)) - y(i,1)).*X(i,2);
    end
    grad(1,1) = grad1; grad(2,1) = grad2;
    for j=1:2
        theta(j,1) = theta(j,1) - (alpha*grad(j,1))/m;
    end
    
    



    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);
    fprintf('%f \n', num2str(J_history(iter,1)));

end

end

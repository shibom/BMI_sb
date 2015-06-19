function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%
%for j=1:size(theta,1)
%     grad_val = 0;
for i=1:m
    X_tmp = X(i,:); %creating row vector from each training example
    X_tmp = (X_tmp)';%took transpose of X_tmp to convert into column vector.
    H = sigmoid(theta'*X_tmp);
    val = -y(i)*log(H) - (1 - y(i))*log(1-H);
    J = J + val;
    %grad_val = grad_val + ((H - y(i))*X(i,j));
end
J = (1./m)*J;
%grad(j) = grad_val/m;
%end

for j=1:size(theta,1)
    grad_val = 0;
    for i=1:m
        H1 = sigmoid(theta'*X(i,:)');
        grad_val = grad_val + ((H1 - y(i))*X(i,j));
    end
grad(j) = grad_val/m;
end
% 





% =============================================================

end

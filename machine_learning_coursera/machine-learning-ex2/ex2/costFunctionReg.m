function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

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
%val2 = 0;
for j=1:size(theta,1)
     %grad_val = 0; %val1 = 0;
for i=1:m
    X_tmp = X(i,:); %creating row vector from each training example
    X_tmp = (X_tmp)';%took transpose of X_tmp to convert into column vector.
    H = sigmoid(theta'*X_tmp);
    val1 = - y(i)*log(H) - (1 - y(i))*log(1-H);
    J = J + val1;
%     if j == 1
%         grad_val = grad_val + ((H - y(i))*X(i,j))/m;
%     else
%         grad_val = grad_val + ((H - y(i))*X(i,j))/m + theta(j)*(lambda/m);
%     end
end
J = J/m;
if j > 1
J = J + (lambda*(theta(j)^2))/(2*m);
end
%grad(j) = grad_val;
end
%val2 = (lambda/m)*val2;
%J = val2;

for j=1:size(theta,1)
     grad1 = 0;
     for i=1:m
         H1 = sigmoid(theta'*X(i,:)');
         grad1 = grad1 + ((H1 - y(i))*X(i,j));
     end
     if j == 1
         grad(j) = grad1/m;
     elseif j > 1
         grad2 = grad1/m + (theta(j)*lambda)/m;
         grad(j) = grad2;
     end
 end


% =============================================================

end

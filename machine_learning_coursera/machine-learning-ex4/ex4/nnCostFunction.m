function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
X = [ones(m, 1) X];

% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


% layer 1 is setting params to X..

active1 = X;
% layer 2, i.e., hidden layer 
z2 = active1*(Theta1)'; 
%z2 = Theta1*active1';

% params for layer 2 calculation

active2 = (sigmoid(z2));
active2 = [ones(m,1) active2];

% layer 3, i.e., output layer
z3 = active2*(Theta2)';
%z3 = Theta2*active2';
H = (sigmoid(z3)); %H is a 5000x10 size matrix
ym = zeros(size(H));



for i=1:m
    if y(i) == 0
        ym(i, 10) = 1;
    else
        ym(i, y(i)) = 1;
    end

end
J = 1.0/m * sum(sum(-ym.*log(H) - (1 - ym).*log(1 - H),2));

J = J + (lambda)/(2*m)*(sum(sum(Theta1(:,2:end).^2,2)) + sum(sum(Theta2(:,2:end).^2,2)));

    %J = sum((-ym(i,:)'*log(H(i,:)) - (1-ym(i,:)')*log(1-H(i,:))));
% for i=1:m
%     val = [];
%     for k=1:num_labels
%         val(k) =  - ym(i,k)*log(H(i,k)) - (1 - ym(i,k))*log(1 - H(i,k));
%     end
%     J = J + sum(val);
% end
% 
% J = sum(J)/m; % un-regularized cost function..
% 
% 
% %calculating regularized term..
% 
% term2 = sum(sum(Theta2(2:end,2:end).^2));
% 
%  tmp1 = 0; tmp2 = 0;
% % 
% for ii=1:hidden_layer_size
%     term1 = 0;
%     for kk=2:input_layer_size
%         term1 = term1 + Theta1(ii,kk)*Theta1(ii,kk);
%     end
%     tmp1 = tmp1 + term1;
% end
% 
% for ii=1:num_labels
%     term2 = 0;
%     for kk=2:hidden_layer_size
%         term2 = term2 + Theta2(ii,kk)*Theta2(ii,kk);
%     end
%     tmp2 = tmp2 + term2;
% end
% 
% J = J + (lambda*tmp1)/(2*m) + (lambda*tmp2)/(2*m);



%Backpropagation

delta3 = H - ym; %size of delta3 5000x10 ..
delta2 = (delta3*Theta2);

display(num2str(size(delta2)));

delta2 = delta2(:,2:end).*(sigmoidGradient(z2)); %size of delta2 5000x25
%delta2 = delta2(2:end); %size of delta2 5000x25

error1 = delta2'*(active1); %size of error1 25x401
Theta1_grad = error1/m;   %size of Theta1_grad = size(Theta1) = 25x401


error2 = delta3'*(active2); %size of error2 10x26
Theta2_grad = error2/m;   %size of Theta2_grad = size(Theta2) = 10x26


%Gradient for regularization

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + (Theta1(:,2:end)*lambda)/m;
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + (Theta2(:,2:end)*lambda)/m;








% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end

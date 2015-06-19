function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

Clist = [0.01,0.03,0.1,0.3,1,3,10,30]';
%sig = sqrt(Clist);
sig = Clist;
x1 = [1,2,1]; 
x2 = [0,4,-1];
% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
predstore = zeros(length(Clist),length(sig));

for i=1:length(Clist)
    for j=1:length(sig)
        model= svmTrain(X, y, Clist(i), @(x1, x2) gaussianKernel(x1, x2, sig(j)));
        preds = svmPredict(model, Xval);
        predstore(i,j) = mean(double(preds ~= yval));
    end
end

[minsig,cols] = min(predstore, [], 2);
[~,min_idx] = min(minsig);
sigma = sig(cols(min_idx));

[minC,rows] = min(predstore, [], 1);
[~,min_Cidx] = min(minC);

C = Clist(rows(min_Cidx)); %sigma = sig(cols);








% =========================================================================

end

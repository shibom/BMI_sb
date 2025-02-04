function [bestEpsilon, bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%
pval = double(pval);
bestEpsilon = 0;
bestF1 = 0;
F1 = 0; %zeros(1000,1);

stepsize = (max(pval) - min(pval)) / 1000;
count = 0;
epi = (min(pval):stepsize:max(pval))';

for epsilon = min(pval):stepsize:max(pval)
    count = count + 1;
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    preds = zeros(size(yval));
    
    for i=1:length(pval)
        if pval(i) < epsilon
           preds(i) = 1;
          % disp(preds(i));
        end
    end
   % disp(find (preds == 1));
    
    tp = 0; fp = 0; fn = 0;
    for j=1:length(yval)
        if preds(i) == 1 && yval(i) == 1
            tp = tp + 1;    
        elseif preds(i) == 1 && yval(i) == 0
            fp = fp + 1;
        elseif preds(i) == 0 && yval(i) == 1
            fn = fn + 1;
        end
    end
    precision = tp/(tp+fp);
    recall = tp/(tp+fn);
    F1 = (2*precision)/(precision+recall);


    %disp(F1);









    % =============================================================
%for i=1:1000
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end

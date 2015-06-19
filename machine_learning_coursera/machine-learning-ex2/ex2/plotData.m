function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

positive_loc = find(y == 1);
negative_loc = find(y == 0);

plot(X(positive_loc, 1), X(positive_loc, 2), 'b+', 'LineWidth', 2, 'MarkerSize', 8);
plot(X(negative_loc, 1), X(negative_loc, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 8);
hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%









% =========================================================================



hold off;

end

function [ results ] = createArrays( nArrays, array_size )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
results = cell(nArrays,1);
for i = 1 : nArrays
        results{i} = zeros(array_size);
end


end


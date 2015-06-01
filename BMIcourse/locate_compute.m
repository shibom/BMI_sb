function [ des_per_img ] = locate_compute( imagename )

%This function does an automated edge detection and finds out locations of
%those edges and pulls out features from those locations using daisy
%algorithm.. It returns an array of size(no. of features, 200), where each
%row stands for each feature pixel with 200 numbers, which represent
%feature vector from that particular pixel point.

%   Detailed explanation goes here


im = imread(imagename, 'tiff');
im = rgb2gray(im);
im_edgy = edge(im,'canny',[0.025,0.05],1);
[x, y] = find(im_edgy == 1);
dzy = compute_daisy(im);
ind_x = find(x<dzy.w-1);
ind_y = find(y<dzy.h-1);
if size(ind_x) >= size(ind_y)
   des_per_img = zeros(numel(ind_y),200);
   for i = 1:size(ind_y)
    j = ind_x(i); k = ind_y(i);
    des = display_descriptor(dzy, y(k), x(j));
    des = (des(:))';
    des_per_img(i,:) = des_per_img(i,:) + des;
   end
end
return
% else
%     des_per_img = zeros(numel(ind_x),200);
%     for i = 1:size(ind_y)
%         j = ind_x(i); k = ind_y(i);
%         des = display_descriptor(dzy, y(k), x(j));
%         des = (des(:))';
%         des_per_img(i,:) = des_per_img(i,:) + des;
%     end
% end
end


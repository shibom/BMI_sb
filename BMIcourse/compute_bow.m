function [ des_per_img ] = compute_bow( imagename )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

im = rgb2gray(imread(imagename, 'jpg'));
dz = compute_daisy(im);
kp_x = [199,533,754,525,325,355,650,764,99,103,700,222,391,442,555,861,654,...
     476,440,438,400,452,857];
kp_y = [85,207,48,50,454,463,469,470,460,397,345,272,342,288,526,538,272,172,...
    220,118,540,405,220];
% figure(1);
% imshow(im);
% hold on;

des_per_img = zeros(23,200);

for i = 1:23
    des = display_descriptor(dz, kp_y(i),kp_x(i));
    des = (des(:))';
    des_per_img(i,:) = des_per_img(i,:) + des;
end
 %[idx, cnts] = kmeans(des_per_img,23); 
% 
% hist_per_img = zeros(size(des_per_img));
% for i = 1:23
%     hist_per_img(i,:) = hist_per_img(i,:) + des_per_img((clusts == i),:);
% end
% 
% % figure(2);
% 
% histo = hist(clusts, 23);
% bar(histo);
% 
% for i = 1:23
%     subplot(4,6,i);
%     %for j = 1:200
%         %junk = des_per_img(:,j);
%     plot(des_per_img((idx == i),:),'*');
%     plot(cnts(i,:));
%     %end
% end

% figure(3);
% hist_per_img = hist(des_per_img, 23);
% plot(hist_per_img);
% hold on;


end


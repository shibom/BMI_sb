function [ descriptors_all_images ] = suffled_training( folder, images_to_shuffle )

%This function goes into a folder with polyp images, and finds out a no. of
%random images for training (that no. is user input, i.e.,
%images_to_shuffle). Then, it uses a rectangular grid. It identifies pixel
%location of the center of each of the box of the grid and pulls out the
%daisy descriptor from each of those positions and stores them for each
%image. Also, it returns a big array containing descriptors from all
%training images..That big array can be further used for kmeans clustering
%and random forests..

filetype = fullfile(folder, '*.tiff');
files = dir(filetype);
nfiles = length(files);
count = randperm(nfiles); % shuffling the indexes of images..
count = count(1:images_to_shuffle); % find out those many images which is asked from the user inputs.

descriptors_all_images = {}; % declare a cell-array to store all features from all images..

for ic = 1:numel(count)
    cidx = count(ic);
    basename = files(cidx).name;
    currentfile = fullfile(folder, basename);
    im = imread(currentfile, 'tiff');
    [x, y] = meshgrid(130:10:550, 80:10:450);
    px = (x(1,:))'; py = y(:,1);
    dzy = compute_daisy(im);
    des_per_img = [];
    for i=1:(size(px)-1)
        for j=1:(size(py)-1)
            tx = (px(i) + px(i+1))/2; % calculating center position of each box in the grid
            ty = (py(j) + py(j+1))/2;
            des = display_descriptor(dzy, ty, tx); %desplay daisy feature from those center positions
            des = (des(:))';
            des_per_img = [des_per_img; des]; % get the descriptors from one image
        end
    end
    descriptors_all_images = [descriptors_all_images, des_per_img]; % append the cell array with descriptors from each image and eventually store from all images
end

descriptors_all_images = (descriptors_all_images)';
descriptors_all_images = cell2mat(descriptors_all_images); % convert the cell into array containing features from all training images.

end


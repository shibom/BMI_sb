function [ features, all_descriptors ] = auto_feature( folder )

%auto_feature will go into folder and locate and compute daisy features
%for each of those edge detected pixel locations. It returns a structured
%array where image name and corresponding feature matrix containing feature
%from all pixels will be stored.


filetype = fullfile(folder, '*.tiff');
files = dir(filetype);
nfiles = length(files);

%Initialize the structured array of features from each image;

features(nfiles).name = 'junk';
features(nfiles).daisy = [];
all_descriptors = {}; % declare a cell to store all features info from all images and later convert that into a big array of all features..

%let's read all images and store the daisy features from all the edge
%detected pixels into a structure..

for i = 1:nfiles
    basename = files(i).name;
    currentfile = fullfile(folder, basename);
    des_per_img = locate_compute(currentfile);
    all_descriptors = [all_descriptors, des_per_img];
    features(i) = struct('name',currentfile,'daisy',des_per_img);
        
end

all_descriptors = (all_descriptors)'; % transpose the cell to get row = total no. of images, and cols = 200 numbers from each daisy descriptior..

%lets convert the cell into an array which is more convenient to use for
%further analysis..
all_descriptors = cell2mat(all_descriptors);

end


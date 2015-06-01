function [ patch3d_all, all_label ] = patchy( folder )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%ground = '../CVC-ColonDB/CVC-ColonDB';

filetype = fullfile(folder,'*tiff');
files = dir(filetype);
nfiles = length(files);

patch3d_all = {}; all_label = [];
patch3d_all_p = {}; patch3d_all_np = {};


for i=1:nfiles
    basename = files(i).name;
    current = fullfile(folder, basename);
    [patch_polyp, patch_nonpolyp] = patch_find(current);
    patch3d_all_p{i} = patch_polyp;
    patch3d_all_np{i} = patch_nonpolyp;
    
end

patch3d_all = cat(3, patch3d_all_p{1:length(patch3d_all_p)},patch3d_all_np{1:length(patch3d_all_np)});

%size(cell2mat(patch3d_all_p))

all_label = uint8(zeros(size(patch3d_all,3),1));
all_label(1:12*length(patch3d_all_p)) = 1;
end


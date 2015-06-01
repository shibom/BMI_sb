function [ patches, labels ] = patchy1( folder )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here



filetype = fullfile(folder, '*tiff');
files = dir(filetype);
nfiles = length(files);
patches = {}; labels = uint8(zeros(nfiles*180,2));

for i=1:nfiles
    basename = files(i).name;
    current = fullfile(folder,basename);
    img_dat = tiling(current);
    patches{i} = img_dat;
    npatch = size(img_dat,3);
    [path, name, ext] = fileparts(current);
    if strcmp(name(1:2),'N_')
        labels(npatch*(i-1)+1:i*npatch,1) = 1;
    elseif strcmp(name(1:2),'P_')
        labels(npatch*(i-1)+1:i*npatch,2) = 1;
    end
end

patches = cat(3, patches{1:length(patches)});

end


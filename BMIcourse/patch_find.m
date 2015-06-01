function [ output, output1, label ] = patch_find( imagename )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

VIEW = 0;

ground = '../CVC-ColonDB/CVC-ColonDB';
[path, name, ext] = fileparts(imagename);
basename = strcat(name, ext);
patch = []; 

im = rgb2gray(imread(imagename, 'tiff'));
truth =strcat('cp',basename);
check = fullfile(ground,truth);
check = imread(check,'tiff');

se = strel('line',10,10);
check = imdilate(check, se);
[x, y] = find(check == 255);
width = (max(x) - min(y));
height = (max(y) - min(y));

polyp = imcrop(im, [min(y), min(x), width+20, height+20]);
%fprintf('size: %d,%d\n',size(polyp));

mask = ones(size(im));
mask(min(x):max(x),min(y):max(y)) = 0;
mask = uint8(mask);
Irest = im.*mask;

if VIEW
    imshow(polyp);
end

if size(polyp) > [0,0]
        polyp = imresize(polyp, [32 32]);
        pol_lr = fliplr(polyp);
        pol_fl = flipdim(polyp,2);
        patch = cat(3,polyp,pol_lr,pol_fl);
        for i=1:3
            pol = imrotate(polyp, 90*i);
            pol = imresize(pol, [32 32]);
            pol_lr = fliplr(pol);
            pol_fl = flipdim(pol,2);
            patch = cat(3,patch,pol,pol_lr,pol_fl);
        end
end
label = uint8(zeros(2*size(patch,3),1));

[row,col] = size(Irest);
blockR = 32; blockC = 32;
min_d = min(row,col);
tileR = floor(min_d/blockR);
tileC = floor(min_d/blockC);
dim = [tileR*blockR, tileC*blockC];

start_x = floor((row-dim(1))/2);
start_y = floor((col-dim(2))/2);

Irest = Irest(start_x+1:start_x+dim(1),start_y+1:start_y+dim(2));
np_patch = [];
[row1, col1] = size(Irest);
output1 = {};
for ii=1:row1/blockR
        for kk=1:col1/blockC
            oneBlock = Irest(blockR*(ii-1)+1:blockR*ii,blockC*(kk-1)+1:blockC*kk);
            if size(oneBlock) == [32,32]
               Block_lr = fliplr(oneBlock);
               Block_fl = flipdim(oneBlock,2);
               np_patch = cat(3,oneBlock,Block_lr,Block_fl);
               for j=1:3
                  oneBlock = imrotate(oneBlock,90*j);
                  Block_lr = fliplr(oneBlock);
                  Block_fl = flipdim(oneBlock,2);
                  np_patch = cat(3,np_patch,oneBlock,Block_lr,Block_fl);
               end
            end
        end
        output1{ii} = np_patch;
end

output = patch;
output1 = cat(3,output1{1:length(output1)});

label(1:size(patch,3)) = 1;
end


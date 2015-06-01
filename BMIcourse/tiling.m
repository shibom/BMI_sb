function [ tile_data ] = tiling( imagename )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

im = rgb2gray(imread(imagename, 'tiff'));
im = medfilt2(im, [10 10]);
im = imcrop(im, [110,60,470,350]);

[row,col] = size(im);
blockR = 32; blockC = 32;
min_d = min(row,col);
tileR = floor(min_d/blockR);
tileC = floor(min_d/blockC);
dim = [tileR*blockR, tileC*blockC];

start_x = floor((row-dim(1))/2);
start_y = floor((col-dim(2))/2);

im = im(start_x+1:start_x+dim(1),start_y+1:start_y+dim(2));
np_patch = [];
[row1, col1] = size(im);
tile_data = {};

for ii=1:row1/blockR
        for kk=1:col1/blockC
            oneBlock = im(blockR*(ii-1)+1:blockR*ii,blockC*(kk-1)+1:blockC*kk);
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
     tile_data{ii} = np_patch;
end

tile_data = cat(3, tile_data{1:length(tile_data)});

end


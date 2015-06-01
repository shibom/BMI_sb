function [ detected_loc, Image_data ] = detect_edge( imagename )

%This function will take one polyp image with full path. 
%Then, it will do filtering, edge detection, finding curves and circular
%polyp shapes. Then, it will store all those locations into an array called
%detected_loc. It will return that array and Image_data as an array 
%for the use of Daisy and further analysis..
%If you want to view the images,then set VIEW=1;

VIEW = 1;

Irgb = imread(imagename, 'tiff');
I = rgb2gray(Irgb);
I = imcrop(I, [70,55,450,400]);
filtered = medfilt2(I,[25 25]); % filtering and smooth out bright reflections..
level = graythresh(filtered);   % Estimate background .. 
bw = im2bw(filtered, level);
im_edgy = edge(bw,'canny',[0.04,0.07],1); % Edge detected..

if VIEW
    figure; subplot(1,3,1);
    imshow(filtered);title('Filtered image');
    subplot(1,3,2);
    imshow(im_edgy);
    title('Edge detection');
end

%Lets find out curves and circular polyp shapes..

stat = regionprops(im_edgy, 'centroid');
centers = stat.Centroid; centers = int16(centers);
rads = 30;

if VIEW
    subplot(1,3,3); 
    imshow(I); hold on;
    viscircles(centers, rads, 'EdgeColor', 'g');
    hold on;
end

%lets look at hough circles..
    
[cnts, radii, metric] = imfindcircles(im_edgy,[18 40], 'Sensitivity', 0.98, ...
    'EdgeThreshold', 0.8, 'Method', 'TwoStage');
cnts = int16(cnts); radii = int16(radii);

if VIEW
    viscircles(cnts, radii, 'EdgeColor', 'b');
    title('circles on polyp');
    hold on;
end

%put all found locations into one array..
    
    detected_loc = []; 
    detected_loc = [detected_loc; centers(:,1),centers(:,2)];
    if size(cnts) > [0,0]
        detected_loc = [detected_loc;cnts(:,1),cnts(:,2)];
    end
    
    Image_data = I;

end


%This is a matlab script, which is aimed to train polyp classifier using
%polyp data. It looks into a folder of training images, and also ground
%truth image folder. It uses detect_edge.m function for polyp detection.
%Make sure you have got that..
%Then, you can choose to shuffle randomly 100 images
%from the folder or not.Also you can choose to rotate daisy descriptor or
%not. Recommended settings are shuffle = 1; and rotation = 1; If you want to skip
%any of these options, just set that value to 0, i.e., shuffle = 0 or so
%on. Currently if choosen to rotate descriptors, it will use 2500 trees for
%classification otherwise it will use 100 trees. You can of course change
%these things. Above all, please set the correct paths for the folders.
%Then hit the run button and go for a coffee.. :)


folder = '../CVC-ColonDB/only_data/test';
ground = '../CVC-ColonDB/CVC-ColonDB';
shuffle = 1; rotation = 1;

if exist(folder, 'dir');
    filetype = fullfile(folder, '*.tiff');
    files = dir(filetype);
    nfiles = length(files);
else
    error('I could not find the folder. Give me correct path. \n');
    return
end

if shuffle
    count = randperm(nfiles);
    count = count(1:100);
else
    numel(count) = nfiles;
end

test_des = []; truth_label = [];
scores = []; test_img = [];

for i=1:length(count)
    if shuffle
        id = count(i);
    else
        id = i;
    end
    
    basename = files(id).name;
    current = fullfile(folder, basename);
    [detected_loc, I] = detect_edge(current);
    
    fprintf('location detected. going to calculate daisy: %s: \n', current);
    fprintf('image no: %d \n', i);
    
    dzy = compute_daisy(I,30,3,8,8);
    
    for j=1:size(detected_loc(:,1))
        des = display_descriptor(dzy, detected_loc(j,2), detected_loc(j,1));
        
        if rotation
            
            fprintf('I am rotating descriptors \n');
            
            rot_des_90 = rot90(des); rot_des_90 = (rot_des_90(:))';
            rot_des_180 = rot90(des,2); rot_des_180 = (rot_des_180(:))';
            rot_des_270 = rot90(des,3); rot_des_270 = (rot_des_270(:))';
            des = (des(:))';
            test_des = [test_des; des,rot_des_90, rot_des_180, rot_des_270];
        else
            des = (des(:))';
            test_des = [test_des; des];
        end
        % Be consistent between train and test. If you use rotation for
        % training, make sure to use rotation for test as well..
        
 %       fprintf('I am checking with classifier \n');
        
%         if rotation
%             Ntrees = 2500;
%             [predict, metric] = polyp_classifier.predict(test_des);
%             scores = [scores;metric];
%             test_img = [test_img; predict];
%         else
%             Ntrees = 100;
%             [predict, metric] = polyp_classifier.predict(test_des);
%             scores = [scores;metric];
%             test_img = [test_img; predict];
%         end
        
        %checking with ground truth labeled images..
    
        truthname = strcat('p',basename);
        truthimage = fullfile(ground,truthname);
        sanity = imread(truthimage, 'tiff');

        if rotation
            if sanity(detected_loc(j,2), detected_loc(j,1)) == 255 && ...
               sanity(detected_loc(j,2)-30, detected_loc(j,1)) == 255 && sanity(detected_loc(j,2), detected_loc(j,1)-30) == 255 && ...
               sanity(detected_loc(j,2)+30, detected_loc(j,1)) == 255 && sanity(detected_loc(j,2), detected_loc(j,1)+30) == 255
                truth_label = [truth_label; 'p'];
            else
                truth_label = [truth_label; 'n'];
            end

        else
            if sanity(detected_loc(j,2), detected_loc(j,1)) == 255
                truth_label = [truth_label; 'p'];
            else
                truth_label = [truth_label; 'n'];
            end
        end
    end
end

fprintf('I am checking with classifier \n');

Ntrees = 2500;
[predict, metric] = polyp_classifier.predict(test_des);
scores = [scores;metric];
test_img = [test_img; predict];

fprintf('lets check ROC plot for test images \n');

[fpr,tpr,~,auc] = perfcurve(truth_label, scores(:,2), 'p');
figure;
plot(fpr,tpr,'LineWidth', 2); 
xlabel('False Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('True Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
title(['ROC Tests with ', num2str(Ntrees),' trees classifier; AUC: ', ...
    num2str(auc)], 'FontSize', 14, 'FontWeight', 'bold');
fprintf('AUC value: %f \n', auc);
        
        
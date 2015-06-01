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



folder = '../CVC-ColonDB/only_data';
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

des_per_img = []; truth_label = [];

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
    
    dzy = compute_daisy(I,30,3,8,8);
    
    for j=1:size(detected_loc(:,1))
        des = display_descriptor(dzy, detected_loc(j,2), detected_loc(j,1));
        
        if rotation
            
            fprintf('I am rotating descriptors \n');
            
            rot_des_90 = rot90(des); rot_des_90 = (rot_des_90(:))';
            rot_des_180 = rot90(des,2); rot_des_180 = (rot_des_180(:))';
            des = (des(:))';
        else
            des = (des(:))';
        
        end
        if rotation
            des_per_img = [des_per_img; des, rot_des_90, rot_des_180];
        else 
            des_per_img = [des_per_img; des];
        end
        
    %checking with ground truth labeled images..
    
        truthname = strcat('p',basename);
        truthimage = fullfile(ground,truthname);
        sanity = imread(truthimage, 'tiff');

        if rotation
            if sanity(detected_loc(j,2), detected_loc(j,1)) == 255
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

fprintf('I am done! now try to classify\n');

if rotation
    polyp_classifier = TreeBagger(2500, des_per_img, truth_label, 'Method', ...
    'classification', 'oobpred', 'on');
else
    polyp_classifier = TreeBagger(100, des_per_img, truth_label, 'Method', ...
      'classification', 'oobpred', 'on');
end

figure; plot(oobError(polyp_classifier));
xlabel('# of Trees', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('OOB Error', 'FontSize', 14, 'FontWeight', 'bold'); 
hold on;

%checking quality of the classification..

fprintf('Lets check ROC plots \n');

[~, Sfit] = oobPredict(polyp_classifier);

[fpr,tpr, ~, auc] = perfcurve(polyp_classifier.Y, Sfit(:, 2), 'p');
figure;
plot(fpr,tpr,'LineWidth', 2);
xlabel('False Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('True Positive Rate', 'FontSize', 14, 'FontWeight', 'bold');
title(['ROC with 2500 trees; AUC: ', num2str(auc)], 'FontSize', 14, 'FontWeight', 'bold');
fprintf('AUC: %f \n', auc);

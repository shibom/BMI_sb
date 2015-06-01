
%This script is a wrapper of all other functions. It looks up the folder
%and finds out 100 images randomly, collect all features. Then it runs
%clustering with 2 to 200 different no. of clusters and each time it plots
%mean silhouette value as a function of no. of clusters. Also, it runs
%TreeBagger or random forest classification tool on the features, extracted
%from all those 100 images for each clustering. Then plot Out-of-Bag error
%for each clustering with No. of trees = 100..

folder = '/Users/pluto/Documents/stuffs/BMI598/Colonoscopy_image_database/N';

%storing all features from all 100 randomly picked training images using
%suffled_training function
tic

all_features = suffled_training(folder, 100);
ncluster = [];
ncluster = [ncluster;2:20,50,100,150,200];
ncluster = ncluster(:);
stat = []; Ntree = 100; % this is no. of trees to be used in a random forest.

for k=1:size(ncluster)
    [idx, cnts] = kmeans(all_features, ncluster(k),'distance', 'cosine', 'Display', 'iter', ...
        'Replicates', 5);
%     [sil,~] = silhouette(all_des, idx, 'cosine'); % calculate Silhouette metric for each clustering..
%     stat = [stat; ncluster(k),mean(sil)];
    RF_for_all = TreeBagger(Ntree, all_features, idx, 'OOBPred', 'On'); % run random forest classification for each clustering..
    plot(oobError(RF_for_all), 'LineWidth', 2); % plotting out-of-bag error for each clustering..
    xlabel('No. of Clusters', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Mean Silhouette value', 'FontSize', 14, 'FontWeight', 'bold');
    legend(num2str(ncluster(k)));
    hold all;
end
% figure();
% plot(stat(:,1),stat(:,2), '*-', 'LineWidth', 2);
% xlabel('No. of Clusters', 'FontSize', 14, 'FontWeight', 'bold');
% ylabel('Mean Silhouette value', 'FontSize', 14, 'FontWeight', 'bold');
% hold on

toc



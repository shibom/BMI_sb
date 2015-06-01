folder = '/Users/shibombasu/Documents/R_program/BMIcourse/cars_markus/training_car_imgs';

filetype = fullfile(folder, 'image_*.jpg');
files = dir(filetype);
nfiles = length(files);

all_des = createArrays(10,[23,200]);
nclusters = 23;

for i = 1:nfiles
    basename = files(i).name;
    currentfile = fullfile(folder, basename);
    des_per_img = compute_bow(currentfile);
    all_des{i} = des_per_img;
end

all_des = cell2mat(all_des);

[idx, cnts] = kmeans(all_des, nclusters, 'Replicates', 5);

%let's plot the histogram for bag of words..
figure(1);
histogram(idx, 50, 'Normalization', 'count');
xlabel('Features');
ylabel('counts');
hold on;

%lets check how the clustering looks like..


% figure(2);
%     for j=1:nclusters
%         subplot(4,6,j);  
%         plot(all_des(idx == j,:), '*');
%         hold on;
%     end
clc;

Train = '../Colonoscopy_image_database/train';
Test = '../Colonoscopy_image_database/test';

[TrainX, TrainY] = patchy1(Train);
[Train, Train_indx] = datasample(TrainX, 100000, 3);
class_train = TrainY(Train_indx,:);

[TestX, TestY] = patchy1(Test);
[Test, Test_indx] = datasample(TestX, 50000, 3);
class_test = TestY(Test_indx,:);

save('project1_tr5.mat','Train','class_train','Test','class_test');
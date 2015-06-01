clc;

Train = '../CVC-ColonDB/train1';
Test = '../CVC-ColonDB/test1';

[TrainX, TrainY] = patchy(Train);
[TestX, TestY] = patchy(Test);

save('data.mat','TrainX','TrainY','TestX','TestY');
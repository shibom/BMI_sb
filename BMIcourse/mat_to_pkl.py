#!/usr/opt/local/bin/env python

from scipy.io import matlab
import numpy as np
import cPickle
import random
import sys


mat = matlab.loadmat(sys.argv[1]);

training_data = np.float32(mat['Train'])
test_data = np.float32(mat['Test'])

train_label = np.int32(mat['class_train'])

test_label = np.int32(mat['class_test'])


training_data = np.reshape(training_data, (60000,1024));
test_data = np.reshape(test_data, (20000,1024));

'''
tmp1 = training_data[5000:10000,:]
tmp2 = training_data[25000:30000,:]


valid_data = np.concatenate((tmp1, tmp2), axis=0);

tmp1 = train_label[5000:10000,:]
tmp2 = train_label[25000:30000,:]

valid_label = np.concatenate((tmp1,tmp2), axis=0)
'''

seq = range(training_data.shape[0])

rand_picks = random.sample(seq, 5000);

valid_data = np.zeros((5000,1024))
valid_label = np.zeros((5000,2))

for i in rand_picks:
    valid_data += training_data[i,:] 
    valid_label += train_label[i,:]

train_label = train_label.flatten()
valid_label = valid_label.flatten()
test_label = test_label.flatten()

train_set = (training_data, train_label)

valid_set = (valid_data, valid_label)
test_set = (test_data, test_label)

sets = (train_set, valid_set, test_set)

with open(sys.argv[2], 'wb') as f:
     cPickle.dump(sets, f)
    # cPickle.dump(valid_set, f)
    # cPickle.dump(test_set, f)

f.close()



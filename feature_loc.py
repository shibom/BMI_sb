#!/opt/local/bin/env python

import sys
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

def circle(radius,angle,h,k):
    return h+radius*np.cos(angle), k+radius*np.sin(angle)


filename = "/Users/shibombasu/Documents/R_program/BMIcourse/cars_markus/training_car_imgs/image_0001.jpg"

im = Image.open(filename)
im = np.array(im)
print im.shape
theta = np.arange(0,6.28,0.01)
r = 10; h = 199; k = 85;

x, y = np.ogrid[0:384, 0:512]
mask1 = np.ogrid[100:130,30:70]

mask = ((y-h)**2 + (x-k)**2) <= r**2
'''
im1 = im[mask]
im[mask] = 0
im[mask1] = 0
print im1
'''
'''
for i in range(idx[0].size):
    for j in range(idx[1].size):
        nose += im[x[i],y[j],1]

print nose
'''
plt.figure(1)
plt.imshow(im)
plt.plot(*circle(r,theta,h,k), color='r')
plt.plot(*circle(r, theta, 533, 207), color='r')
plt.plot(*circle(r, theta, 754, 48), color='r')
plt.plot(*circle(r, theta, 525, 50), color='r')
plt.plot(*circle(r, theta, 325, 454), color='r')
plt.plot(*circle(r, theta, 355, 463), color='r')
plt.plot(*circle(r, theta, 650, 469), color='r')
plt.plot(*circle(r, theta, 764, 470), color='r')
plt.plot(*circle(r, theta, 99, 460), color='r')
plt.plot(*circle(r, theta, 103, 397), color='r')
plt.plot(*circle(r, theta, 700, 345), color='r')
plt.plot(*circle(r, theta, 222, 272), color='r')
plt.plot(*circle(r, theta, 391, 342), color='r')
plt.plot(*circle(r, theta, 442, 288), color='r')
plt.plot(*circle(r, theta, 555, 526), color='r')
plt.plot(*circle(r, theta, 861, 538), color='r')
plt.plot(*circle(r, theta, 654, 272), color='r')
plt.plot(*circle(r, theta, 476, 172), color='r')
plt.plot(*circle(r, theta, 440, 220), color='r')
plt.plot(*circle(r, theta, 438, 118), color='r')
plt.plot(*circle(r, theta, 400, 540), color='r')
plt.plot(*circle(r, theta, 452, 405), color='r')
plt.plot(*circle(r, theta, 857, 220), color='r')
plt.show()

'''
#plt.figure(2)
#plt.imshow(im1)
#plt.show()
'''

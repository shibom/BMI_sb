#!/opt/local/bin/env python

import os, sys

def getfilepath(directory):
    filepath = [];
    
    for root, dir_name, files in os.walk(directory):
        for filenames in files:
            filepaths = os.path.join(root, filenames)
            filepath.append(filepaths)

    return filepath

def searchfiles(lst_of_filepaths):

    desired_files = [];

    for f in lst_of_filepaths:
        if f.endswith(".tiff"):
           desired_files.append(f)

    return desired_files    


allfiles = getfilepath(sys.argv[1]);

imagefiles = searchfiles(allfiles);

print imagefiles

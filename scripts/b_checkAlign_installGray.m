%% b_checkAlign_installGray.m
% Mount the gray segmentation and check alignment
%
% Adapted from Winawer lab (NYU)

%% Clean and start
mrvCleanWorkspace();
clear; clc;
subjPathTemp = pwd();

vw = mrVista;
% open a 3D volume view
vol = open3ViewWindow('volume');

% Define an ROI that is the entire functional slab
vw = newROI(vw, 'inplane', true);
dataSize = viewGet(vw, 'anat size');
[x, y, z] = ind2sub(dataSize, 1:prod(dataSize));
vw = viewSet(vw, 'ROI coords', [x; y; z]);

% Project this ROI to the volume so that we can see the slice selection
% within the volume
vol = ip2volCurROI(vw ,vol);
vol = refreshScreen(vol, 0);

close(viewGet(vol, 'figure number')); 
mrvCleanWorkspace
% clear;
% Remember where we are
curdir = pwd()

%% Align inplane to t1 and install Gray/white segmentation
% Open a hidden view
vw = initHiddenInplane();

% Segmentation inputs
query = false;       
% keep all gray nodes, including those outside functional FOV
keepAllNodes = true; 
subj = pwd();
% path to class file
filePaths = fullfile(subj, '3DAnatomy', 't1_class.nii.gz');
% number of layers in gray graph along surface (3 layers for 1 mm voxels)
numGrayLayers = 5;

%% Do it
installSegmentation(query, keepAllNodes, filePaths, numGrayLayers);

%% Visualize
% open a UI
vw = mrVista;
% Define an ROI that is the entire functional slab
vw = makeGrayROI(vw); 
vw = refreshScreen(vw,0);
% add the local variable, vw, to the UI in case you would like to interact
% with the GUI
updateGlobal(vw)

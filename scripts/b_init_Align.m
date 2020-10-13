clear; clc;
mrvCleanWorkspace();

subjPathTemp = pwd();

%% Initialize a vistasoft session
% EPI files. These are your functional images
epiFile{1}     = fullfile('Raw','expanding_ring_RUN1.nii');
epiFile{2}     = fullfile('Raw','expanding_ring_RUN2.nii');
epiFile{3}     = fullfile('Raw','rotating_wedges_RUN1.nii');
epiFile{4}     = fullfile('Raw','rotating_wedges_RUN2.nii');
% Inplane and Anatomical images
inplaneFile    = fullfile('Inplane', 'myInplane.nii'); 
anatFile       = fullfile('3DAnatomy', 't1.nii.gz');

%% Generate the params structure
params = mrInitDefaultParams;
% And insert the required parameters: 
params.inplane      = inplaneFile; 
params.functionals  = epiFile; 
params.sessionDir   = pwd(); 
params.vAnatomy     = anatFile; 
% Subject ID 
params.subject      = 'test1';
% Name for each of the three scans. Use the same order you used above!
params.annotations = {'eccen out YG','eccen out YG','polar CCW YG','polar CCW YG'};
% Do the initialization: 
ok = mrInit(params); 

%% Open a graphical user interface to ensure that we succeeded
vw = mrVista('inplane');

%% Clean up
% close(viewGet(vw, 'figure number')); 
% mrvCleanWorkspace
% clear

%% Next step: MANUALLY Align inplane to t1 and install Gray/white segmentation

%% Illustrates how to initialize the volume anatomy and class file from a
% freesurfer directory.
% Adapted from Winawer lab (NYU)

%% Check whether freesurfer paths exist
fssubjectsdir = getenv('SUBJECTS_DIR');

%% Create t1 anatomy and t1 class files from freesurfer
% Store current directory (retinotopy mrSESSION directory)
curdir = pwd(); 

%% Create t1 anatomy and class file
% mkdir 3DAnatomy;

%% Get the anatomy
outfile = fullfile('3DAnatomy', 't1_class.nii.gz');
fillWithCSF = true;
alignTo = fullfile(fssubjectsdir, 'your_FSsubject_folder', 'mri', 'orig.mgz');
fs_ribbon2itk('your_FSsubject_folder', outfile, fillWithCSF, alignTo);
 
% Check that you created a t1 class file (ribbon) and t1 anatomy
ls 3DAnatomy  
% The command window should show:
% t1.nii.gz	t1_class.nii.gz

%% Visualize
% Show the volume anatomy, segmentation, and anatomy masked by segmentation
ni = niftiRead(fullfile('3DAnatomy', 't1.nii.gz'));
t1 = niftiGet(ni, 'data');
ni = niftiRead(fullfile('3DAnatomy', 't1_class.nii.gz'));
cl = niftiGet(ni, 'data');

fH = figure('Color','w');

% Choose one slice to visualize from the middle of head
sliceNum = size(t1,3)/2;

% Volume anatomy, 
subplot(1,3,1)
imagesc(t1(:,:,sliceNum), [0 255]); colormap gray; axis image
title('Volume anatomy')

subplot(1,3,2)
imagesc(cl(:,:,sliceNum), [1 6]);   axis image
title('Class file')

subplot(1,3,3)
mask = cl(:,:,sliceNum) > 1;
imagesc(t1(:,:,sliceNum) .* uint8(mask));   axis image
title('Masked anatomy')

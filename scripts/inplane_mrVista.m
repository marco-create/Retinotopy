%% source https://github.com/vistalab/vistasoft/issues/179

ni = niftiRead('your_EPI.nii'); % use the name of the nifti functional image to use
data = mean(niftiGet(ni, 'data'), 4);
ni = niftiSet(ni, 'data', data);
dims = niftiGet(ni, 'dim');
ni = niftiSet(ni, 'dim', [dims(1:3) 1]);
ni.fname = 'myInplane.nii'; % save as myInplane.nii
niftiWrite(ni);

# Retinotopy
[Retinotopy](http://fourier.eng.hmc.edu/e180/lectures/v1/node3.html) is a procedure to map the projections of visual neurons from the retina to the visual brain areas.:eyes: :brain:   
The following procedure has been created to provide a clear and step-by-step pipeline in modelling the features of population receptive fields (pRF) of neurons in visual areas of human brain.   
The main software is [mrVista](https://github.com/vistalab/vistasoft) developed by [vistalab](https://github.com/vistalab) from Stanford University.   
The functional preprocessing is made using Statistical Parametric Mapping ([SPM12](https://www.fil.ion.ucl.ac.uk/spm/)).   

Stimuli definition:   
- expanding ring :arrow_right: 6 cycles;   
- rotating wedge (counterclockwise):arrow_right: 6 cycles.   
We have two runs for each stimulus.   

### 0. Freesurfer reconstruction of anatomical surface
Use [Freesurfer](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki) to reconstruct the anatomical surface from T1 image ([check this tutorial](https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FS_ShortCourse/FS_03_ReconAll.html)).   
Follow the instructions on how to set up Freesurfer on your system.   
   
The `reconall` step lasts about 8-9 hours!

## Setting up folder tree :file_folder:
Create a *Projects* directory in your system and inside that a directory named *Retinotopy*.   
Create the following tree inside the retinotopy directory:
```bash
C:.
└───Retinotopy
    └───subject_01
        ├───3DAnatomy
        ├───Inplane
        ├───Raw
        └───Stimuli
```
Cd into the subject folder. 
```
cd subject_01
```
mrVista software requires an [*Inplane image*](https://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/Inplane) to proceed. If you did not acquire that, like me, just run the `inplane_mrVista.m` script. Remember to paste in in the `niftiRead` call, one of your functional images:   
```
cd ./Raw
inplane_mrVista.m
movefile myInplane ../Inplane
% now return into the main subject folder
cd ../
```

### 1a. Anatomical image and meshes from Freesufer
To obtain the anatomical after Freesurfer autorecon, run `anatFrom_FS.m`.   
Just remember to change the subject name, inside the script (lines 18 and 19), to match the Freesurfer output subject.   
   
After that, run `meshFrom_FS.m` to obtain 3D meshes for both hemispheres.   
Again, change the subject name accordingly (line 12).

### 1b. Preprocessing using SPM
Briefly, use SPM to preprocess functional imaging.   
The steps I've being used are:   
- [x] realign: est+reslice
- [x] coregister: est
- [x] normalise: est+write

Use only one batch, defining two sessions; one session for expanding ring and one for rotating wedge.

### 2. Session creation
Now you can run the init function  `a_init_Align.m` to generate the *mrSESSION* inside the subject folder.  
Just remember to change EPI scans name from line 8. You can modify also line 24 and 26 with annotations:
```
% Subject name
params.subject      = 'your_subject_name';
% Name for each of the loaded scan (2 rings and 2 wedges in this case)
params.annotations = {'eccen out','eccen out','polar CCW','polar CCW'};
```   
and run it.   
Now an Inplane window should be opened.   
<img src=https://user-images.githubusercontent.com/53913990/95835842-043adf80-0d3f-11eb-928e-e911b314e40f.png width="400">

### 3. Align inplane to anatomical image manually   
Click on
```
Edit >>> Edit/View Aligment...
```
to open the alignment panels.   
This step needs few practice but you can find an helpful [video tutorial here](https://www.youtube.com/watch?v=e8yfAlb7hFQ&t=260s&ab_channel=visualfmri).
Follow all the steps she is performing and save    
- [x] Xform Settings   
- [x] mrVista alignment   
- [x] mrVista bestrotvol

and you can exit from there.   
To save and close the inplane window, click on
```
File >>> Save Preferences
File >>> Quit
```
in this way, you keep everything clean.

### 4. Check alignment and install gray segmentation
Now you can run the script ```b_checkAlign_installGray.m```. Remember to stay in the subject directory, where the mrSESSION has been created.   
Check the new mounted gray ROI on the inplane. If it looks reasonably well, save and close inplane as we did above. Otherwise, repeat the alignment.   
<img src=https://user-images.githubusercontent.com/53913990/95838745-7234d600-0d42-11eb-951c-26e13f4402ad.png width="400">   

### 5. Average time series from GUI
Open again an Inpane view
```
mrVista
```
and go to 
```
Analysis >>> Time Series >>> Averages tSeries
```
a new window has been opened:   
<img src=https://user-images.githubusercontent.com/53913990/95839312-29c9e800-0d43-11eb-811d-30a287b9e3b0.png width="400">
   
Start with the eccentricity runs. 
  - Inside the *Annotation for average scan?* write *Average of Eccentricity*;   
  - Select *(1) eccen out* and *(2) eccen out* scans and press *OK*. Wait until the process is completed;
  - repeat for Polar. Go to *Averages tSeries*, change the annotation to *Average of Polar*;
  - Select *(1) polar CCW* and *(2) polar CCW* scans and press *OK*. Wait until the process is completed.
  
Now, in the Inplane window, if you click on the menu *dataType:*, on the right side of the GUI, you can select the *Averages* (before it was only *Originals*).   
Save and close.   

### 6. Tranform the time series using trilinear interpolation
In the MATLAB command window, run ```c_interpol.m```. A new UI window is opened.   
<img src=https://user-images.githubusercontent.com/53913990/95840514-8679d280-0d44-11eb-9f11-c391ab7da8cb.png width="400">   
Be sure to select the *Averages* in *dataType:* !   

Now you are ready to compute the correlation analyses for eccentricity and polar maps.
Go to
```
Analysis >>> Travelling Waves Analyses >>> Compute corAnal >>> compute corAnal (all scans)
```
the process is quite fast. You can load the maps going to   
```
File >>> corAnal >>> load corAnal
```
to see the map on the three axes, click to ```View >>> Phase map```.   
Use the slider menus on the right side of the GUI to adjust the threshold.   
<img src="https://user-images.githubusercontent.com/53913990/95956847-2eec6d00-0dff-11eb-8801-a28fd9f555fe.png" width="400">   


### 7. Meshes visualisation
From the current window (3 view), open meshes to visualise eccentricity or polar map on 3D surfaces.   
```
Gray >>> Surface Mesh >>> Load and Display
```
Choose which hemisphere you want to display. An additional window showing a 3D brain surface should be show up.   
Back to 3 view GUI,   
```
Gray >>> Update Mesh
```   
Eccentricity map   
<img src="https://user-images.githubusercontent.com/53913990/95957578-2a748400-0e00-11eb-983f-90b3a4f8e891.png" width="400"><img src="https://user-images.githubusercontent.com/53913990/95958699-cc48a080-0e01-11eb-9d42-a6e96689b719.png" width="200">   
Polar map   
<img src="https://user-images.githubusercontent.com/53913990/95957931-ac64ad00-0e00-11eb-8a30-691534534019.png" width="400"><img src="https://user-images.githubusercontent.com/53913990/95958092-efbf1b80-0e00-11eb-8b3d-9dbcb79354f2.png" width="100">

**TO DO** :clock3:   
- [x] General overview of retinotopy pipeline;   
- [ ] population receptive field (pRF);   
- [ ] mapping surface with polar map;   
- [ ] SPM batch for preprocess automatization;   

# Utils and links
All files are *adapted* from mrVista tutorials.
⬇️⬇️⬇️⬇️
- [Tutorial](https://github.com/vistalab/vistasoft/wiki/Ernie-Tutorials);
- [Inplane creation](https://github.com/vistalab/vistasoft/issues/179);
- [Init and Inplane view](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/session/t_initVistaSession.m);
- [Install segmentation](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/session/t_installSegmentation.m);
- [Trilinear interpolation](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/statistical/t_pRF.m)

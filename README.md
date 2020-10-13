# Retinotopy
### Few background here

### 0. Freesurfer reconstruction of anatomical surface
Use [Freesurfer](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki) to reconstruct the anatomical surface from T1 image ([check this tutorial](https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FS_ShortCourse/FS_03_ReconAll.html)).

## Setting up folder tree
Create a *Projects* directory in your system and inside that a *Retinotopy* directory.   
Initial tree inside the retinotopy directory:
```bash
C:.
└───Retinotopy
    └───subject_01
        ├───3DAnatomy
        ├───Inplane
        ├───Raw
        └───Stimuli
```
Cd inside the subject folder. 
```
cd subject_01
```
mrVista software requires an [*Inplane image*](https://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/Inplane) to proceed. If you did not acquire that, like me, just run the `inplane_mrVista.m` script. Remember to paste in in the `niftiRead` one of your functional images:   
```
cd ./Raw
inplane_mrVista.m
movefile myInplane ../Inplane
% now return into the main subject folder
cd ../
```

### 1a. Anatomical image and meshes from Freesufer
To DO

### 1b. Preprocessing using SPM
To Do

### 2. Session creation
Now you can run the init command to generate the *mrSESSION* inside the subject folder.  
Just remember to change:   
```
% Subject name
params.subject      = 'test_01';
% Name for each of the loaded scan (2 rings and 2 wedges in this case)
params.annotations = {'eccen out','eccen out','polar CCW','polar CCW'};
```
and run the `a_init_Align.m`.   
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

# Utils and links
All files are *adapted* from mrVista tutorial.
⬇️⬇️⬇️⬇️
- [Tutorial](https://github.com/vistalab/vistasoft/wiki/Ernie-Tutorials);
- [Inplane creation](https://github.com/vistalab/vistasoft/issues/179);
- [Init and Inplane view](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/session/t_initVistaSession.m);
- [Install segmentation](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/session/t_installSegmentation.m);
- [Trilinear interpolation](https://github.com/vistalab/vistasoft/blob/master/tutorials/bold/statistical/t_pRF.m)

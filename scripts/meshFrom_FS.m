% Illustrates how to create mrVista compatible meshes from a freesurfer
% surface.
% 
% Adapted from NYU Winawer lab

%% Check whether freesurfer paths exist
fssubjectsdir = getenv('SUBJECTS_DIR');

%% Create and save meshes
hemi = 'b';
surfaces = {'white' 'pial' 'sphere' 'inflated'};
[meshes, fnames] = meshImportFreesurferSurfaces('your_subject_folder', hemi, surfaces);

%% Visualize 
for m = 1:4
    
    figure,
    
    % Faces (also called triangles) are defined by 3 points, each of
    % which is an index into the x, y, z vertices
    faces = meshes(m).triangles' + 1; % we need to 1-index rather than 0-index for Matlab
    
    % The vertices are the locations in mm spacing
    x     = meshes(m).vertices(1,:)';
    y     = meshes(m).vertices(2,:)';
    z     = meshes(m).vertices(3,:)';
    
    % The colormap will, by default, paint sulci dark and gyri light
    c     = meshes(m).colors(1,:)';
    
    % Render the triangle mesh
    tH = trimesh(faces, x,y,z);
    
    % Make it look nice
    set(tH, 'LineStyle', 'none', 'FaceColor', 'interp', 'FaceVertexCData',c)
    axis equal off; colormap gray; set(gca, 'CLim', [0 255])
    
    % Lighting to make it look glossy
    light('Position',100*[0 1 1],'Style','local')
    lighting gouraud
    
    % Which mesh are we plotting?
    title(meshes(m).name)
    
    % Rotate it
    set(gca, 'View', [-16.7000  -90.0000]);
    
end

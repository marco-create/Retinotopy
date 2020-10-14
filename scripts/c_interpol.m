%% c_interpol.m
% Tranform the time series using trilinear interpolation
%
% Adapted from Winawer lab (NYU)

%% Navigate
clear; clc;
subPathTemp = pwd()
cd(subPathTemp); 

%% Transform averaged data from inplane (EPI space) to volume (gray view)
% Open hidden inplane and gray views
ip  = initHiddenInplane(); 
vol = initHiddenGray(); 

% Set them both to the 'Averages' dataTYPE
ip  = viewSet(ip,  'Current DataTYPE', 'Averages');
vol = viewSet(vol, 'Current DataTYPE', 'Averages');

% Check how many scans
scans = 1:viewGet(ip, 'num scans'); 

% Tranform the time series using trilinear interpolation
vol = ip2volTSeries(ip, vol, scans, 'linear'); 

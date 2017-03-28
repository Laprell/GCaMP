%% GCaMP zoom analysis
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script analyses the GCaMP6M fluorescence over time from two regions
% of interest.
% This script searches the directory for files called "Results.txt", which
% is the results file from ROI analysis in Fiji (saved as *.txt file).
%
% The analysis is done by subtracting the background ROI from the
% illuminated dendrite as well as the control dendrite and plots the data
% according to the time stamp of the file.
% The summary plot still needs modification depending on the experimental
% day. This will be implemented in the next version.

% The following scripts are called within this script:
%   1. load_raw_data_zoom
%   2. correctbaseline_zoom


%% General comments on the script
%{
Improvements that can be made: 
    1. final ROI_control and ROI_ill cell arrays should contain the file
    path
    2. include summary: automatic recognize whether control or LOVSoc
    expressing cell was imaged
%}

%%
%find all folders in directory that contain the word 'overview'
%directory='L:\DATA\170317\';
[folders_with_zoom, num_folders, directory] = openfolders('zoom');
cd (directory);

%% all variables
ROI_ill_all{1, num_folders} = [];
all_exp_num{1, num_folders} = [];
all_exp_time{1, num_folders} = [];

%% check if a Results.txt file exists in the current directory. If file does not exists, move to next directory.
for k = 1:num_folders; 
   path = folders_with_zoom {1,k}; 
    if exist([path, '\Results.txt'], 'file');
        load_raw_data % loads the raw data
        timestamps % reads in the timestamps of the individual files
        addtime_zoom_experiments % adds time to the file timestamps, because every file consists of 50 frames, which should be plot individually
        [ROI_ill_baselinecorrected] = correctbaselinefn(5, ROI_ill, ROI_background) % calls the function for baseline subtraction
        % Now loop through all results of the day and save in one cell array.
        ROI_ill_all {k} = ROI_ill_baselinecorrected;
        all_exp_time {:,k} = exp_num; % add all timestamps to a cell array to use for overview plot later
        GCaMP_plot_individual_experiments % plots the individual experiments and saves them in their respective folders.    
    end
    
    are_you_done
    
end

%% overview graph of the directory
lovsoc_vs_control_zoom


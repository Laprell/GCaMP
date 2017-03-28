%%
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

% The following scripts are called within this script:
%   1. timestamps
%   2. load_raw_data
%   3. correctbaseline

%% General comments on the script
%{
Improvements that can be made:
    1. final ROI_control and ROI_ill cell arrays should contain the file
    path
%}

%%
%function GCaMP_analysis_automatic(folders_with_overview, num_folders, directory)
%find all folders in directory that contain the word 'overview'
% directory = uigetdir('L:\DATA\');
[folders_with_overview, num_folders, directory] = openfolders('overview');
cd (directory); %change current directory

%% all variables. ROI_ill = dendrite that was illuminated. ROI_controll = dendrite that was not illuminated.
% all_exp_num = timestamps of the files. 
ROI_ill_all{1, num_folders} = [];
ROI_control_all{1, num_folders} = [];
all_exp_num{1, num_folders}= [];

%% check if a Results.txt file exists in the current directory. If file does not exists, move to next directory.
for k = 1:num_folders
    path = folders_with_overview {1,k};
    if exist([path, '\Results.txt'], 'file');
        %load_file_number; %calls the function for loading the exact experiment number
        timestamps;
        load_raw_data; % pulls the raw data from Results.txt (ROI_Fiji)
        [ROI_ill_baselinecorrected, ROI_control_baselinecorrected] = correctbaselinefn(10, ROI_ill, ROI_background, ROI_control);
        % Now loop through all results of the day and save in one cell array.
        ROI_ill_all {k} = ROI_ill_baselinecorrected;
        ROI_control_all {k} = ROI_control_baselinecorrected;
        all_exp_num {k} = time;         
        GCaMP_plot_individual_experiments % plot data and save plots in the respective folders
    end
    
    are_you_done % make sure all files were analyzed.
end

%% plot overview graph of directory
lovsoc_vs_control_plot
% overview_bleach_combine
%end
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
% all_exp_num = either the acutal experiment number. For the overview
% script this is the time difference between the experiments, i.e. file
% timestamp.
ROI_ill_all{1, num_folders} = [];
ROI_control_all{1, num_folders} = [];
all_exp_num{1, num_folders}= [];

%% check if a Results.txt file exists in the current directory. If file does not exists, move to next directory.
for i = 1:num_folders
    path = folders_with_overview {1,i};
    if exist([path, '\Results.txt'], 'file');
        %load_file_number; %calls the function for loading the exact experiment number
        timestamps;
        load_raw_data; % pulls the raw data from Results.txt (ROI_Fiji)
        % calls the script for baseline subtraction (usually x=2 or 4, i.e. the first four images are taken as baseline)
        [ROI_ill_baselinecorrected, ROI_control_baselinecorrected] = correctbaselinefn(10, ROI_ill, ROI_background, ROI_control);
        % Now loop through all results of the day and save in one cell array.
        ROI_ill_all {i} = ROI_ill_baselinecorrected;
        ROI_control_all {i} = ROI_control_baselinecorrected;
        all_exp_num {i} = exp_num;
        %%
        
        %% Make a beautiful graph from the results and save the figures to the respective folders. Make this a function to call in the if-loop above.
        %change path into pathname to plot on top of the figure
        path_name = strrep(path, '\', ' ');
        path_name = strrep(path_name, '_', ' ');
        %
        %make figure without displaying it.
        figure ('visible', 'off')
        plot (exp_num, ROI_control_baselinecorrected, 'marker', 'o', 'color', 'k')
        hold on
        plot (exp_num, ROI_ill_baselinecorrected, 'marker', 'o', 'color', 'r')
        title (path_name)
        xlabel('duration of experiment'), legend('not ill','ill','Location','northwest')
        
%         fnam='figure_overview.fig';
%         jnam='figure_overview.bmp';
%         
%         save_path = strrep(path, '\overview', ''); % save figure one level up.
%         saveas(gcf,[save_path,filesep,fnam],'fig');
%         print([save_path,filesep,jnam],'-dbmp', '-r100');
        
    end
    % make sure all files were analyzed.
    if i == num_folders
        analyzed_files = length (ROI_ill_all);
        X = ['You''re done. No further files to analyze in this directory! You analyzed ',num2str(analyzed_files),' files out of ' num2str(i) ' files'];
        disp (X)
    end
end

%% plot all controls in one graph and all LOVSoc in one graph
% lovsoc_vs_control_plot
% overview_bleach_combine
%end
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

%% check if a Results.txt file exists in the current directory. If file does not exists, move to next directory.
for i = 1:num_folders; 
%for i=3;
   path = folders_with_zoom {1,i}; 
    if exist([path, '\Results.txt'], 'file');
        %load_file_number; %calls the function for loading the exact experiment number
        timestamps;
        load_raw_data_zoom; % pulls the raw data from Results.txt (ROI_Fiji)
        %correctbaseline_zoom; % calls the script for baseline subtraction (usually x=4, i.e. the first four images are taken as baseline)
        [ROI_ill_baselinecorrected] = correctbaselinefn(5, ROI_ill, ROI_background);
        
        %exp_num = 1:1:length(ROI_ill);
        % Now loop through all results of the day and save in one cell array.
        ROI_ill_all {i} = ROI_ill_baselinecorrected;
        all_exp_num {i} = exp_num; 
                
        %% Make a beautiful graph from the results and save the figures to the respective folders. Make this a function to call in the if-loop above.
        %change path into pathname to plot on top of the figure
        path_name = strrep(path, '\', ' ');
        path_name = strrep(path_name, '_', ' ');
        
        %make figure without displaying it.
        %figure ('visible', 'off')
        figure
        plot (exp_num, ROI_ill_baselinecorrected, 'marker', '.', 'color', 'r')
        title (path_name)

        fnam='figure_zoom.fig';
        %plot(1:10);
        saveas(gcf,[path,filesep,fnam],'fig');
        
    end
    if i == num_folders
        analyzed_files = length (ROI_ill_all);
        X = ['You''re done. No further files to analyze in this directory! You analyzed ',num2str(analyzed_files),' files out of ' num2str(i) ' files'];
        disp (X)  
    end
end


%%
lovsoc_vs_control_zoom
%%



% %% plot all controls in one graph and all LOVSoc in one graph
% figure
% subplot (2,1,1)
% for k = [1 2 7 8]
% plot (all_exp_num{1,k}, ROI_ill_all{1,k}, 'marker', '.', 'color', 'k')
% hold on
% end
% title ('mKate2')
% xlabel('duration of experiment'), legend('control','Location','northwest')
% % 
% subplot (2,1,2)
% for k = 3:6
% plot (all_exp_num{1,k}, ROI_ill_all{1,k}, 'marker', '.', 'color', 'r')
% hold on
% end
% title ('LOVSoc-mch')
% xlabel('duration of experiment'), legend('LOVSoc','Location','northwest')
% xlim ([0 4000])
%     

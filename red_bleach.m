%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script analyses the bleach in red fluorescence to evaluate laser
% power between experiments.
% This script searches the directory for files called "Results.txt", which
% is the results file from ROI analysis in Fiji (saved as *.txt file).

%%
%find all folders in directory that contain the word 'zoom' for the bleach
%analysis
%folderswithzoom
[folders_with_zoom, num_folders, directory] = openfolders('zoom');
cd (directory);
%% save all bleach.txt in one cell array.
bleach_all_experiments{1, num_folders} = [];
%% store exponential fit data in a matrix
exp_data_1 = [];
exp_data_2 = [];

%% check if a bleach.txt file exists in the current directory. If file does not exists, move to next directory.
for k = 1:num_folders; 
    path = folders_with_zoom {1,k}; 
       if exist([path, '\bleach.txt'], 'file');
        %load_file_number; %calls the function for loading the exact experiment number
        bleach_load_data; % pulls the first 300 data points from bleach.txt
        exp_fit2; %exponential fit of the data
        % Now loop through all results of the day and save in one cell array.
        bleach_all {k} = bleach;
        %% exponential fit of the first 300 data points
        %% Make a beautiful graph from the results and save the figures to the respective folders. Make this a function to call in the if-loop above.
        %change path into pathname to plot on top of the figure
        path_name = strrep(path, '\', ' ');
        path_name = strrep(path_name, '_', ' ');
        %
        %make figure without displaying it.
        figure('visible', 'off')
        figure
        plot (f2, (1:1:(length(bleach))),bleach)
        xlabel('number of frames'), legend('bleach','Location','northwest')
        ax1 = gca;
        ax1.YLim =[0 1.1];
        % data exponential fit
        exp_fit = num2str(exp_data_1{1,k});
        text(125,0.2,exp_fit);
        %bleach max (first three data points)
        avg_bleach = num2str(avg_bleach);
        text(125, 0.1, avg_bleach);
        
        fnam='figure_bleach.fig';
        jnam='figure_bleach.bmp';
        save_path = strrep(path, '\zoom in', ''); % save figure one level up.
        saveas(gcf,[save_path,filesep,fnam],'fig');
        print([save_path,filesep,jnam],'-dbmp','-r100');
      end
  
% make sure all files were analyzed.
    are_you_done
end


%% overview figure
red_bleach_plot

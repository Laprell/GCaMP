
%% GCaMP plot individual experiments
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% GCaMP zoom plots
%Distinguishes between experiments with control dendrite and without.

        %% Make a beautiful graph from the results and save the figures to the respective folders. Make this a function to call in the if-loop above.
        %change path into pathname to plot on top of the figure
        path_name = strrep(path, '\', ' ');
        path_name = strrep(path_name, '_', ' ');
        
        %make figure without displaying it.
        %figure ('visible', 'off')
        figure
        
        if exist ('ROI_control_baselinecorrected', 'var')
            plot (time, ROI_ill_baselinecorrected, 'marker', 'o', 'color', 'r')
            hold on
            plot (time, ROI_control_baselinecorrected, 'marker', 'o', 'color', 'k')
            title (path_name);
            xlabel('duration of experiment'), legend('not ill','ill','Location','northwest')
        
           fnam='figure_overview.fig';
           jnam='figure_overview.bmp';
           save_path = strrep(path, '\overview', ''); % save figure one level up.
           saveas(gcf,[save_path,filesep,fnam],'fig');
           print([save_path,filesep,jnam],'-dbmp', '-r100');
        
        else
            plot (exp_num, ROI_ill_baselinecorrected, 'marker', '.', 'color', 'r')
            title (path_name);
            xlabel('duration of experiment'), legend('ill','Location','northwest')
  
            fnam='figure_zoom.fig';
            saveas(gcf,[path,filesep,fnam],'fig');
        end
        
        

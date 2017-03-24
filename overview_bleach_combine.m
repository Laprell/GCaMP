%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% combine figures with GCaMP6M and bleach

%%
 for i = 1:num_folders; 
    path = folders_with_overview {1,i}; 
    path = strrep(path, '\overview', '');
    if exist([path, '\figure_overview.fig'], 'file');
        fig1 = open([path, '\figure_overview.fig']);
        fig2 = open([path, '\figure_bleach.fig']);
        
        figure ('Position', [100, 100, 1100, 500], 'visible', 'off')
        
        h(1)=subplot(1,2,1);
        ax = gca;
        ax.YLim = [-2000 3000];
        ax.XLim = [0 0.055];
        path_name = strrep(path, '\', ' ');
        title (path_name);
        
        h(2)=subplot(1,2,2);
        ax1 = gca;
        ax1.YLim = [0 1.1];
       
        % Paste figures on the subplots
        copyobj(allchild(get(fig1,'CurrentAxes')),h(1));
        copyobj(allchild(get(fig2,'CurrentAxes')),h(2));
        fnam='combined.fig';
        jnam='combined.bmp';
        saveas(gcf,[path,filesep,fnam],'fig');
        print([path,filesep,jnam],'-dbmp', '-r100');     
    end
 end
%%
 

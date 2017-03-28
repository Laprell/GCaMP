%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% CAUTION: This script requires that LOVSoc in never named in the directory, only if
% it is acutally expressed. 

%%
% select the files with LOVSoc to plot only those in one graph and select
% all other files (i.e. controls) and plot in second graph
%%
% select the folders that contain the word 'LOVSoc' as "true"
folders_LOVSoc = cellfun(@(folders_with_zoom) ~isempty(folders_with_zoom), strfind(folders_with_zoom, 'LOVSoc'));

%% plot all controls in one graph and all LOVSoc in one graph
figure
subplot (2,1,1)

%for j = [1 2 7 8] % all control experiments; this needs to be adjusted depending on the experiment order
for j = find(~folders_LOVSoc)
    plot (all_exp_time{1,j}, ROI_ill_all{1,j}, 'marker', '.', 'color', 'r')
    hold on
end
title ('ctrl-mKate2')
xlabel('duration of experiment'), legend('ill','Location','northwest')
ax1 = gca; % get axis handle for later to adjust both axes identically
% 
subplot (2,1,2) % with LOVSoc

%for j = 3:6 % all LOVSoc experiments; this needs to be adjusted depending on the experiment order
for j = find(folders_LOVSoc)
    plot (all_exp_time{1,j}, ROI_ill_all{1,j}, 'marker', '.', 'color', 'r')
    hold on
end
title ('LOVSoc-mch')
xlabel('duration of experiment'), legend('ill','Location','northwest')
ax = gca; % get axis handle

%%
% adjust both axis to the first (or second) 
xlim = ax1.XLim;
ylim = ax.YLim;

ax.XLim = xlim;
ax1.YLim = ylim;

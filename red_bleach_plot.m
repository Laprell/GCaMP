%%red_bleach_plot
% this only works, if the GCaMPzoom protocol ran first. Otherwise variables
% are not defined.

%% to identify folders with LOVSoc and those without LOVSoc later
folders_LOVSoc = cellfun(@(folders_with_zoom) ~isempty(folders_with_zoom), strfind(folders_with_zoom, 'LOVSoc'));

%% plot all controls in one graph and all LOVSoc in one graph
figure
subplot (2,1,1)

for j = find(~folders_LOVSoc)
    plot (all_exp_num{1,j}, ROI_ill_all{1,j}, 'marker', '.', 'color', 'r')
    hold on
end
title ('ctrl-mKate2')
xlabel('duration of experiment'), legend('ill','Location','northwest')
ax1 = gca; % get axis handle for later to adjust both axes identically
% 
subplot (2,1,2) % with LOVSoc

for j = find(folders_LOVSoc)
    plot (all_exp_num{1,j}, ROI_ill_all{1,j}, 'marker', '.', 'color', 'r')
    hold on
end
title ('LOVSoc-mch')
xlabel('duration of experiment'), legend('ill','Location','northwest')
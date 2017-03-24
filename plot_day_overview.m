
%%
% Author: Laura Laprell
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script 
%%
figure
subplot(2,1,1)
for k = [1 2 7 8] %controls mKate2
plot (all_exp_num{1,k}, ROI_ill_all{1,k}, 'marker', '.', 'color', 'k')
hold on
end
title ('LOVSoc-mch')
ylabel('duration of experiment'), legend('not ill','ill','Location','northwest')

hold on

subplot(2,1,2)
for l = 3:6 %LOVSoc
    plot (all_exp_num{1,l}, ROI_ill_all{1,l}, 'marker', '.', 'color', 'r')
    hold on
end
title ('LOVSoc-mch')
ylabel('duration of experiment'), legend('not ill','ill','Location','northwest')

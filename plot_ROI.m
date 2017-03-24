
function [plot_ROIs] = plot_ROI(ROI_control_baselinecorrected, ROI_ill_baselinecorrected);
figure
plot (ROI_control_baselinecorrected)
hold on
plot (ROI_ill_baselinecorrected)
end
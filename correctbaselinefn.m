%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% [ROI_ill_baselinecorrected,ROI_control_baselinecorrected] = correctbaselinefn(number_to_average, ROI_ill, ROI_background, ROI_control);
%
% This script subtracts the baseline from the subsequent trials. x is the
% number of images taken for the average subtraction and should be changed
% according to the experiment.

%%
function [ROI_ill_baselinecorrected,ROI_control_baselinecorrected] = correctbaselinefn(number_to_average, ROI_ill, ROI_background, ROI_control)
%x=5 %number of images used for the baseline

%subtract the background trance from ROI_ill and ROI_control
ROI_ill = ROI_ill-ROI_background;
if exist ('ROI_control', 'var')
    ROI_control = ROI_control-ROI_background;
end 

%average first four stimuli for "normalization"
baseline_ROI_ill = mean (ROI_ill (1:number_to_average));
if exist ('ROI_control', 'var')
    baseline_ROI_control = mean (ROI_control (1:number_to_average));
end 

%subtract baseline from ROI_ill und ROI_control
ROI_ill_baselinecorrected = ROI_ill-baseline_ROI_ill;
if exist ('ROI_control','var')
    ROI_control_baselinecorrected = ROI_control-baseline_ROI_control;
end
end


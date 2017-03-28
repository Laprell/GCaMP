%% curvefitting bleach 
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
%%exp_fit2 requires curvefitting toolbox

f2 = fit((1:1:length(bleach))', bleach, 'exp2');
coeff_values = coeffvalues(f2);
exp_data_1{i} = coeff_values(1,2);
exp_data_2{i} = coeff_values(1,4);

%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script analyses the time stamps of the individual overview_images
% form the ROI analysis. The time stamp is used to have the exact time of
% the experiment and not only the experiment number. Usually two images are
% taken within 2 seconds followed by a longer break in between.

%% extract timestamp from file information and use file timestamps to plot and not experiment numbers

D = [path, ('\*.tif')];
d = dir (D);
TimeStamp = {d.date};
time = datetime (TimeStamp, 'InputFormat', 'dd-MMM-yyyy HH:mm:ss');
delta = [];
length_data = length(time);


for j = 1: length_data
    diff = time(1,j)-time(1,1);
    delta = [delta, diff];
end

time = delta;

%%
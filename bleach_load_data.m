%% Measure bleach of red fluorescence
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script reads in the "bleach.txt", which
% is the results file from ROI analysis in Fiji (saved as *.txt file).

% Import data from text file and rename according to ROI.

%% Initialize variables.
filename = fullfile(path, '\bleach.txt');
%filename = 'L:\DATA\170314\slice2cell5dendrite1control\zoom\bleach.txt';
delimiter = '\t';
startRow = 2;
endRow = 301;

formatSpec = '%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
bleach = dataArray{:, 3};

%% Clear temporary variables
clearvars filename delimiter startRow endRow formatSpec fileID dataArray ans;


%% normalize bleach data
% average first 3 data points
avg_bleach = mean (bleach (1:3));
bleach = bleach/avg_bleach;
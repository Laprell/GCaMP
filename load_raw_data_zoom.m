%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script reads in the "Results.txt", which
% is the results file from ROI analysis in Fiji (saved as *.txt file).

% Import data from text file and rename according to ROI.
% This requires that always the illuminated area is the first ROI and the
% backgroun is the second ROI.
% If the data does not match these requirements, this script needs to be
% adapted.
%% Import data from text file and rename according to ROI

%% Initialize variables.
filename = fullfile(path, '\Results.txt');

delimiter = '\t';
startRow = 2;

%% Format string for each line of text:
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.

%% Allocate imported array to column variable names
ROI_ill = dataArray{:, 3};
ROI_background = dataArray{:, 7};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%% 
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 
% This script reads in the "Results.txt", which
% is the results file from ROI analysis in Fiji (saved as *.txt file).

% Import data from text file and rename according to ROI.

% CAUTION:
% This requires that always the illuminated area is the first ROI, the
% control dendrite is the second ROI and the background is the third ROI.
% If the data does not match these requirements, this script needs to be
% adapted.

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
%in the experiments with overview there is one more ROI (i.e. the control
%dendrite), whereas the zoom in does not have this control. Therefore, the
%zoom in experiments have no data in the column for the control dendrite.
%By knowing this, we can distinguish the load functions.

if ~isnan (dataArray{1,11})
    ROI_ill = dataArray{:, 3};
    ROI_control = dataArray{:, 7};
    ROI_background = dataArray{:, 11};
end

if isnan (dataArray{1,11})
    ROI_ill = dataArray{:, 3};
    ROI_background = dataArray{:, 7};
end
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID %dataArray ans;
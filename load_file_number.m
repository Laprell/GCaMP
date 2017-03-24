%% load file names and save number of experiment in cell (r)
% path = uigetdir('L:\DATA\');
names = dir ([path, '\*.tif']);
name = {names(1:end).name}.';
r=strrep(name,'LL','');
r=strrep(r,'.tif','');
exp_num=[cellfun(@str2num,r)];

%import the data into raw_data from Fiji

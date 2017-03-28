%% 
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 2017-03-27
% 
% This script adds time to the individual timestamps of the files. Each
% experiment consists of 50 frames and each frame should be plotted against
% its own time 
%%

n=50; % number of frames

newtime=[];

for i = 1:length_data
    newtime = [newtime; repmat(time(i), n,1)];
end

addtime = seconds(1:50)';
addseconds = [addtime; repmat(addtime, i-1,1)];

exp_num = newtime+addseconds;

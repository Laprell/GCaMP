% find desired folders

function [folders, num_folders, directory] = openfolders(folder_specificity);
directory=uigetdir ('L:\DATA\170317\');
cd (directory); %change current directory

[list_of_folders] = regexp(genpath(directory),'[^;]*','match');

folders_of_interest = cellfun(@(list_of_folders) ~isempty(list_of_folders), strfind(list_of_folders, folder_specificity));
folders = list_of_folders(folders_of_interest);

num_folders = numel(folders); % count number of folders to preallocate vectors and to loop through all files.

end


%dbstop for debugging
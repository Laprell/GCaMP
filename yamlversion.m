%% Yaml-File version
global directory
global i
global lab_books

function [version] = yamlversion(version)
    yaml_file = strcat(directory,'\',lab_books{1,i});
    fid = fopen(yaml_file); % this opens the yaml file to look for the version of the file
    dataArray = textscan(fid, '%q%*s%*s%[^\n\r]', 1, 'delimiter', ','); 
    header = dataArray{:, 1}; %loads only the information about the version of the yaml file used
    header=cell2mat(header); % changes the format of the header so that "~isempty" can be used
    fclose(fid); % closes the yaml file again
end
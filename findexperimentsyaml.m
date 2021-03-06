%%
% Author: Laura Laprell
% Version: 0.1
% at Thomas Oertner Lab, ZMNH, University of Hamburg, UKE
% 2017-03-21
% 
% find experiments 
% this code helps to find all experiments with a specific condition. It scans through all lab books and loads only those of version 0.5
% my previous versions cannot be loaded into matlab structures.
% I added two examples for what can be searched. First, all experiments
% that had TTX in the extracellular solution and second with laserpower 7.
% The structure of the Yaml File can be found in YamlStruct.
% The results will be in experiment_summary

%%
global directory
global i
global lab_books

%directory='L:\DATA\';
directory = uigetdir('L:\DATA\');
cd (directory); %change current directory

lab_books = dir('*lab book*.yaml');
lab_books = struct2cell(lab_books);

experiment_summary = {};

for i=1:length(lab_books)
    %[version] = yamlversion('0.5');
    hello
    yaml_file = strcat(directory,'\',lab_books{1,i});
    fid = fopen(yaml_file); % this opens the yaml file to look for the version of the file
    dataArray = textscan(fid, '%q%*s%*s%[^\n\r]', 1, 'delimiter', ','); 
    header = dataArray{:, 1}; %loads only the information about the version of the yaml file used
    header=cell2mat(header); % changes the format of the header so that "~isempty" can be used
    fclose(fid); % closes the yaml file again
      version = ~isempty(strfind(header, '0.5')); % is true that version 0.5 was used?
    if version
        %display(lab_books{1,i})
        YamlStruct = ReadYaml(yaml_file); %read only yaml files of version 0.5. previous versions cannot be read by this function
        experiment_summary{i,1} = YamlStruct.day; %this cell summarizes all experiments with the information of interest
        
        for j=1:length(YamlStruct.data{:}.slices) % this loop allows to go through the structure of the yaml file
            for k=1:length(YamlStruct.data{:}.slices{1,j}.experiments)
                existing = ~isempty(strfind(YamlStruct.data{:}.slices{1,j}.experiments{1,k}.solution, 'TTX')); % here the information of interest is selected.
                % existing = ~isempty(strfind(YamlStruct.data{1,1}.slices{1,j}.experiments{1,k}.laserpower,7)) % this is a second example for what can be searched
                if existing
                    experiment_summary{i,k+1} = YamlStruct.data{:}.slices{1,j}.experiments{1,k}.name;
                end
            end
        end
    end
end



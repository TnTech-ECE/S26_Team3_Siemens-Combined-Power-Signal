clear

folderpath = 'Cable Data\';

% Get all of the s parameter data files in the folder
SDataFiles = dir(append(folderpath,'*.s2p'));

% Loop through all of the files in the folder and load its data
numFiles = length(SDataFiles);
for k = 1:numFiles
    figure(k)
    S = sparameters(append(folderpath, SDataFiles(k).name));
    rfplot(S);
    title(SDataFiles(k).name)
end
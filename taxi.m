clc;
clear all;
hwait=waitbar(0,'Please wait>>>>>>>>>>>');         %use waitbar to check progress
%Read all files in a folder in batches
TreeDir='G:\Taxi\2014\';                        %direction need to be change
TreeDirs=dir(TreeDir);
CountAll=0;
 Load=0;
Realload=0;
for nData=3:length(TreeDirs)
    if ~TreeDirs(nData).isdir     % Skip if it is not a date folder
        continue;
    end
    ReadDir=[TreeDir,TreeDirs(nData).name,'\'];%Read outer file
    ReadDirs=dir([ReadDir,'*.txt']);  %Extension name. Read all files with txt suffix
    WritePath=['G:\Taxi\2014\',TreeDirs(nData).name,'.txt'];    %time direction need to be change
    CountDirs=length(ReadDirs);
   
    % end
    % list=dir('G:\Taxi\2014');
    % for k=3:size(list,1)
    %     list(k).name
    %     sublist=dir(['G:\Taxi\2014\' '/' list(k).name]);
    %     for n=3:size(list)
    %         sublist(n).name     % Skip if it is not a date folder
    %         ReadDir=['G:\Taxi\2014\',list(k).name,'\'];
    %         ReadDirs=dir([ReadDir,'*.txt']);  %Extension
    %         WritePath=['G:\Taxi\2014\',sublist(n).name ,'.txt'];    %time direction need to be change
    %         CountDir=length(ReadDir);
    for i=1 : CountDirs
        
        fid = fopen([ReadDir,ReadDirs(i).name]);
        Origin = textscan(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',';','CollectOutput',1);
        Origin = Origin{1};
        [row,col]=size(Origin);
        CountAll=CountAll+ row;%Calculate the total number of records
        fclose(fid);
        %         clear Origin fid;
        %=================Caculate the real load record  =================
     
        for n=1 : row
            if (strcmp(Origin(n,12),'5')==1)
                Load=Load+1;
            end
        end
        Realload=Realload+Load;
        Load=0;
       
        %=================Waitbar=================
        str=['Running ',TreeDirs(nData).name,' ',num2str(fix (i/CountDirs*100)),' %'];
        waitbar(i/n,hwait,str);
    end 

end

close (hwait);



function Buildexe(appName, exclList, flags)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BuildExe allows building of the current directories project in 
% without having to change the output directory or update the .m 
% files list, every time (as seems to be the case with deploytool)
%
% Also it finds all the .m files under the current directory 
%

rootdir = filesepStandard(pwd);

% Args 
if ~exist('appName','var')
    [~, appName] = fileparts(rootdir);
end
rootdir = filesepStandard(fileparts(which(appName)));

if ~exist('exclList','var')
    exclList = {};
end
if ~exist('flags','var')
    flags = {};
end

% Matlab compiler generates a readme file that overwrites the app readme
% that already xists. Before we start build , move readme to temp file and 
% at end of build delete the newly generated readme and move the temp one 
% back. 
if ispathvalid('./README.txt', 'file')
    movefile('./README.txt', 'TEMP.txt');
end

% Find main .m file
appDotMFilesStr = '';
sanity = 100;
while ~ispathvalid(appDotMFilesStr, 'file')
    
    appDotMFileMain = sprintf('%s.m', appName);
    
    % Check to make sure main .m file exists
    if ~ispathvalid([rootdir, appDotMFileMain], 'file')
        q = menu(sprintf('Could not find the main application file %s.m. Please locate the main application file.', appName), 'OK');
        [filenm, pathnm] = uigetfile({'*.m'}, 'Select main .m file');
        if filenm==0
            return;
        end
        [~, appName] = fileparts(filenm);
        appDotMFileMain = [pathnm, filenm];
        appDotMFilesStr = appDotMFileMain;
    else
        appDotMFilesStr = filesepStandard(sprintf('%s%s', rootdir, appDotMFileMain'));
    end
    
    sanity = sanity-1;
    if sanity<=0
        return;
    end
   
end
appDotMFilesStr = sprintf('-v %s', appDotMFileMain');

% Get all .m files which will go into making the app executable
appDotMFiles = findDotMFiles(rootdir, exclList);

% Create compile switches string
compileSwitches = '';
for ii = 1:length(flags)
    compileSwitches = [compileSwitches, flags{ii}, ' ']; %#ok<*AGROW>
end
compileSwitches = [compileSwitches, ' -w enable:specified_file_mismatch'];
compileSwitches = [compileSwitches, ' -w enable:repeated_file'];
compileSwitches = [compileSwitches, ' -w enable:switch_ignored'];
compileSwitches = [compileSwitches, ' -w enable:missing_lib_sentinel'];
compileSwitches = [compileSwitches, ' -w enable:demo_license'];

%%% Go through all the apps, contruct a string listing all the .m files 
%%% on which each app depends and then compile the app using mcc.


% Remove main m file and remove Buildme.m from app files list 
appDotMFiles = removeEntryFromList(appDotMFileMain, appDotMFiles);
appDotMFiles = removeEntryFromList('Buildme.m', appDotMFiles);

% Construct files list portion of build command
fid = fopen('./Buildme.log','w');
fprintf(fid, '==================================:\n');
fprintf(fid, 'Building %s from these files:\n', appName);
fprintf(fid, '==================================:\n');
for jj=2:length(appDotMFiles)
    appDotMFilesStr = sprintf('%s -a ''%s''', appDotMFilesStr, appDotMFiles{jj});
    fprintf(fid, '%s\n', appDotMFiles{jj});
end
fprintf(fid, '\n\n');
fclose(fid);

% Complete the final build command and execute it
buildcmdstr = sprintf('mcc -o %s -W main:%s -T link:exe -d ''%s'' %s %s', appName, appName, rootdir, compileSwitches, appDotMFilesStr);
disp(buildcmdstr);
eval(buildcmdstr);

% Delete useless readme generated by mcc and replace it with our own
% readme.txt that already exsisted
if ispathvalid('./README.txt', 'file')
    delete('./README.txt');
end
if ispathvalid('./TEMP.txt', 'file')
    movefile('TEMP.txt','./README.txt');
end






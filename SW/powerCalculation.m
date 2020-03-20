clear
clc
upLimit = 20;
bottLimit = 5;
%open files
[file,path] = uigetfile('*.csv','Select One or More Files','MultiSelect', 'on');

%number of files
if ischar(file)
    numOfFiles = 1;
else
    numOfFiles = size(file,2);
end

if numOfFiles==1
    startTime = datenum(datetime(extractBefore(file,20),'InputFormat','yyyy_MM_dd_HH_mm_ss'));
else        
    startTime = datenum(datetime(extractBefore(file{1},20),'InputFormat','yyyy_MM_dd_HH_mm_ss'));
end

propIter = 1; % Propper iteration without errors.
for i = 1:numOfFiles
    try
        % Initialize variables.
        if numOfFiles==1
            filename = strcat(path,file);
        else
            filename = strcat(path,file{i});
        end    

        delimiter = ',';
        startRow = 22;

        % Format for each line of text:
        %   column1: double (%f)
        %	column2: double (%f)
        %   column3: double (%f)
        formatSpec = '%f%f%f%[^\n\r]';

        % Open the text file.
        fileID = fopen(filename,'r');

        % Read data according to the format.
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

        % Close the text file.
        fclose(fileID);

        % Create output variable
        NewFile1 = table(dataArray{1:end-1}, 'VariableNames', {'Second','Volt','Volt1'});

        %power
        NewFile1.Power = NewFile1.Volt.*NewFile1.Volt1;
        %integrate over time
        area = trapz(NewFile1.Second,NewFile1.Power);
        %get time period
        delta = max(NewFile1.Second) - min(NewFile1.Second);    
        %calculate power
        P = area/delta;
        if isfinite(P) && P < upLimit && P > bottLimit
            if numOfFiles==1
                powerTable{propIter,1} = file;
                
                curTime = datenum(datetime(extractBefore(file,20),'InputFormat','yyyy_MM_dd_HH_mm_ss'));
                timeFromStart = round((curTime-startTime)*24*3600);
                powerTable{propIter,2} = timeFromStart;
            else        
                powerTable{propIter,1} = file{i};
                
                curTime = datenum(datetime(extractBefore(file{i},20),'InputFormat','yyyy_MM_dd_HH_mm_ss'));
                timeFromStart = round((curTime-startTime)*24*3600);
                powerTable{propIter,2} = timeFromStart;
            end
            powerTable{propIter,3} = P;
            %display resaults

            if numOfFiles==1
                dispString = [file,': ', num2str(P), ' W'];
            else        
                dispString = [file{i},': ', num2str(P), ' W'];
            end

            disp(dispString)
            propIter = propIter + 1;
        else
            if numOfFiles==1
               dispString = [file,' - Computation error '];
            else        
                dispString = [file{i},' - Computation error '];
            end            
            disp(dispString)
        end
    catch exception
        if numOfFiles==1
            dispString = [file,' - Import error '];
        else        
            dispString = [file{i},' - Import error '];
        end
        disp(dispString)
    end

    % Clear temporary variables
    
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
end
%%
x = [powerTable{:,2}]';
y = [powerTable{:,3}]';
plot(x/3600,y);
xlabel('Time [H]') 
ylabel('P [W]') 
grid on;
%%
clearvars l i P dispString delta area NewFile1 numOfFiles propIter startTime upLimit bottLimit
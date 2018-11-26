 function [ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS( fname )
% parse_SEMS parses a SEMS .dat file into a matrix and extracts relevant info
%   Inputs:  fname, name of the dat file
%   Outputs: bin concentrations, NUM_ROWSxNUM_BINS Matrix containing particle concentration data
%            bin_diameters, 1xNUM_BINS Vec containing diameter of each of our bins
%            start_times, NUM_ROWSx1 Vec containing start time of each collection
%            end_times, NUM_ROWSx1 Vec containing end time of each collection
   
    format long g

    % % STEP 1: Extract Raw Data
    fid = fopen(fname,'r');
    % Get number of bins
    num_bins_array = textscan(fid,'#Num Bins: %u',1,'delimiter','\n', 'headerlines',11);
    num_bins = num_bins_array{1};
    % Read in file as a 1xN vector
    datacell = textscan(fid, '%f', 'CommentStyle','#', 'Delimiter', ': \t' );
    fclose(fid);
    data = datacell{1};

    % There are 21 columns in the data file before the bin diameters and
    % concentrations columns. However, we split each of the two date 
    % columns into 3 columns, which gives us 25. Each of bin diameters and
    % concentrations has cardinality num_bins.
    NUM_COLS = 25 + 2*num_bins;
    disp(['Scanned ', num2str(size(data,1) / NUM_COLS), ' rows of data.']);
    
    if mod(size(data, 1), NUM_COLS) ~= 0
        disp('Error! Data has an unexpected number of columns. ')
        disp('This data file may have a different number of state columns.')
        return;
    end

    % this is just the raw data from the dat file
    % except we've seperated the start and end time columns into 3 seperate
    % columns each.
    raw_data = reshape(data, NUM_COLS, [])';

    % % STEP 2: Extract Relevant Info
    
    % raw_data contains the following (by column):
    %   Cols 1:6 - time information
    %   Cols 7:25 - state data (we don't care about)
    %   Cols 26:(26+num_bins-1) - bin diameters
    %   Cols (26+num_bins):NUM_COLS - bin concentrations
    
    % Extract Start and End Times
    start_dates = raw_data(:,1);
    start_hours = raw_data(:,2);
    start_minutes = raw_data(:,3);
    start_seconds = raw_data(:,4);
    end_dates = raw_data(:,5);
    end_hours = raw_data(:,6);
    end_minutes = raw_data(:,7);
    end_seconds = raw_data(:,8);
    
    parsed_start_dates = datetime(num2str(start_dates), 'InputFormat', 'yyMMdd'); 
    start_times = parsed_start_dates + hours(start_hours) + minutes(start_minutes) + seconds(start_seconds);
    
    parsed_end_dates = datetime(num2str(end_dates), 'InputFormat', 'yyMMdd'); 
    end_times = parsed_end_dates + hours(end_hours) + minutes(end_minutes) + seconds(end_seconds);
        
    % Extract bin diameters
    bin_diameters = raw_data(1,26:(25+num_bins));
    
    % Extract Bin Concentrations
    bin_concentrations = raw_data(:, (26 + num_bins):NUM_COLS);
    

end


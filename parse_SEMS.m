function [ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS( fname )
% parse_SEMS parses a SEMS .dat file into a matrix and extracts relevant info
    %   Inputs: fname, name of the dat file
    %   Outputs: bin concentrations, NUM_ROWSxNUM_BINS Matrix containing particle concentration data
    %            bin_diameters, 1xNUM_BINS Vec containing diameter of each of our bins
    %            start_times, NUM_ROWSx1 Vec containing start time of each collection
    %            end_times, NUM_ROWSx1 Vec containing end time of each collection
   
    format long g

    % % STEP 1: Extract Raw Data
    fid = fopen(fname,'r');
    % Read in file as a 1xN vector
    datacell = textscan(fid, '%f', 'CommentStyle','#', 'Delimiter', ': \t' );
    fclose(fid);
    data = datacell{1};

    % There are 71 columns in the data file. However, we split each of the 
    % two date columns into 3 columns, which gives us 75.  
    NUM_COLS = 75;
    disp(['Scanned ', num2str(size(data,1) / NUM_COLS), ' rows of data.']);

    if mod(size(data, 1), NUM_COLS) ~= 0
        disp('Error! Data has an unexpected number of columns. ')
        disp('Please update NUM_COLS in parse_SEMS and try again.')
        return;
    end

    % this is just the raw data from the dat file
    % except we've seperated the start and end time columns into 3 seperate
    % columns each.
    raw_data = reshape(data, NUM_COLS, [])';

    % % STEP 2: Extract Relevant Info
    
    % Note: we are assumming that the columns are always the same. If we
    % Use more or less bins, then this parsing will need to change.
    
    % Extract bin diameters
    bin_diameters = raw_data(1,26:50);
    
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
    
    % Extract Bin Concentrations
    bin_concentrations = raw_data(:, 51:NUM_COLS);
    

end


 function [ v1_ranges, v2_ranges ] = parse_switching_file( fname )
% parse_switching_file parses a log file that contains info regarding when 
% the 3-way valve switched between inlet sources
%   Inputs:  fname, name of the switching ile
%   Outputs: v1_ranges, NUM_RANGESSx2 Matrix containing datetime
%   ranges when the valve 1 is open.
%            v2_ranges, NUM_RANGESSx2 Matrix containing datetime
%   ranges when valve 2 is open.

    fid = fopen(fname,'r');
    datacell = textscan(fid,'Valve %d %s', 'Delimiter', '\n');
    fclose(fid);

    valve_numbers = datacell{1};
    unparsed_bits = datacell{2};
    % if we don't have an even number of entries,
    % cut off the last entry
    if mod(length(valve_numbers), 2) ~= 0
    %     TODO: CUT OFF FIRST ENTRY IF ITS A CLOSED %%%%%%%%%%%
        valve_numbers(end) = [];
        unparsed_bits(end) = [];
    end
    
    % preallocate a matrix of arbitraty datetimes 
    times = linspace(datetime(2000, 01, 01, 00, 00, 00), datetime(200, 01, 10), length(unparsed_bits));

    % get a linear array of times
    for i=1:length(unparsed_bits)
        if strncmpi(unparsed_bits{i}, 'Open at', 7)
            % get characters 9-end of string
            % this will get just the datetime portion of the message
            date_string = unparsed_bits{i}(9:end);
        elseif strncmpi(unparsed_bits{i}, 'Closed at', 9)
            % get characters 11-end of string
            % this will get just the datetime portion of the message
            date_string = unparsed_bits{i}(11:end);
        end
        % get a linear array of the times
        times(i) = datetime(date_string, 'InputFormat', 'M/dd/yyyy h:mm:ss a');

    end

    % times repeat in the pattern [v1_opening, v1_closing, v2_opening, v2_closing]
    % we want to turn this into two Nx2 arrays of time ranges
    a_open_times = times(1:4:end);
    a_close_times = times(2:4:end);
    b_open_times = times(3:4:end);
    b_close_times = times(4:4:end);
    a_ranges = horzcat(a_open_times', a_close_times');
    b_ranges = horzcat(b_open_times', b_close_times');

    % which valve does a_ranges correspond to?
    if valve_numbers(1) == 1
        disp('got here')
        v1_ranges = a_ranges;
        v2_ranges = b_ranges;
    elseif valve_numbers(1) == 2
        v1_ranges = b_ranges;
        v2_ranges = a_ranges;
    end

 end
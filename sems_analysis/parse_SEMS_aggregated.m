 function [ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS_aggregated( folder_name )
% parse_SEMS parses multiple SEMS .dat files located within a folder
%   Inputs:  fname, name of the dat file
%   Outputs: bin concentrations, NUM_ROWSxNUM_BINS Matrix containing particle concentration data
%            bin_diameters, 1xNUM_BINS Vec containing diameter of each of our bins
%            start_times, NUM_ROWSx1 Vec containing start time of each collection
%            end_times, NUM_ROWSx1 Vec containing end time of each collection
    files = dir(folder_name);
    bin_concentrations = [];
    start_times = [];
    end_times = [];
    for file = files'
        % Don't iterate through files starting with '.'
        if ~strncmpi(file.name, '.', 1)
            fname = [folder_name '/' file.name];
            disp(['Parsing ' fname])
            [ b_cs, bin_diameters, s_ts, e_ts ] = parse_SEMS( fname );
            bin_concentrations = vertcat(bin_concentrations, b_cs);
            start_times = vertcat(start_times, s_ts);
            end_times = vertcat(end_times, e_ts);
        end
        
    end
    
 end

function [ output_args ] = split_time( split_timepoint,  bin_concentrations, start_times, end_times )
% split_time splits start, end, and bin_concentrations before and after a
% timepoint
    % find biggest end time that is before the split_timepoint
    % [ 1, 2], [3, 4], [5, 6]
    % 3.3          ^   
    % We will choose all elements up to this timepoint
    bin_concentrations_before = bin_concentrations(end_times < split_timepoint,:);
%     bin_concentrations(end_times < split_timepoint)
    
    output_args = bin_concentrations_before;
    
end


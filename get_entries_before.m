function [ bin_concentrations_before, start_times_before, end_times_before ] = get_entries_before( split_timepoint,  bin_concentrations, start_times, end_times )
% get_entries_before returns all data entries before a given timepoint
%   Inputs:  split_timepoint: datetime which to filter data with
%            bin concentrations, NUM_ROWSxNUM_BINS Matrix containing particle concentration data
%            start_times, NUM_ROWSx1 Vec containing start time of each collection
%            end_times, NUM_ROWSx1 Vec containing end time of each collection
%   Outputs: bin concentrations_before, contains particle concentration data occuring before split_timepoint
%            start_times_before, contains start times occuring before split_timepoint
%            end_times_before, contains end times occuring before split_timepoint
    
    % we want all collection points such that the entierity of the
    % collection time range falls before the split_timepoint.
    % this means that the last end_time needs to be before the
    % split_timepoint
    bin_concentrations_before = bin_concentrations(end_times < split_timepoint,:);
    start_times_before = start_times(end_times < split_timepoint);
    end_times_before = end_times(end_times < split_timepoint); 
end


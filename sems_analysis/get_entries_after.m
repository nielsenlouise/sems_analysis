function [ bin_concentrations_after, start_times_after, end_times_after ] = get_entries_after( split_timepoint,  bin_concentrations, start_times, end_times )
% get_entries_after returns all data entries after a given timepoint
%   Inputs:  split_timepoint: datetime which to filter data with
%            bin concentrations, NUM_ROWSxNUM_BINS Matrix containing particle concentration data
%            start_times, NUM_ROWSx1 Vec containing start time of each collection
%            end_times, NUM_ROWSx1 Vec containing end time of each collection
%   Outputs: bin concentrations_after, contains particle concentration data occuring after split_timepoint
%            start_times_after, contains start times occuring after split_timepoint
%            end_times_after, contains end times occuring after split_timepoint
    
    % we want all collection points such that the entierity of the
    % collection time range falls after the split_timepoint.
    % this means that the first start_time needs to be after the
    % split_timepoint
    bin_concentrations_after = bin_concentrations(start_times > split_timepoint,:);
    start_times_after = start_times(start_times > split_timepoint);
    end_times_after = end_times(start_times > split_timepoint); 
end


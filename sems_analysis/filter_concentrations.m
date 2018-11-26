function [filtered_concentrations, filtered_start_times, filtered_end_times ] = filter_concentrations( parse_switch_out, bin_concentrations, start_times, end_times)
% filter_concentrations returns all data entries within range of pairs of given timepoints
%   Inputs:  parse_switch_out: pairs of datetimes to filter data with
%            bin_concentrations: NUM_ROWSxNUM_BINS Matrix containing particle concentration data
%            start_times: NUM_ROWSx1 Vec containing start time of each collection
%            end_times: NUM_ROWSx1 Vec containing end time of each collection
%   Outputs: filtered_concentrations: contains particle concentration data occurring in ranges specified by parse_switch_out
%            filtered_start_times: filtered_concentrations: contains start times occurring in ranges specified by parse_switch_out
%            filtered_end_times: filtered_concentrations: contains end times occurring in ranges specified by parse_switch_out
    
    [filtered_concentrations, filtered_start_times, filtered_end_times] = get_entries_middle(parse_switch_out(1,1), parse_switch_out(1,2), bin_concentrations, start_times, end_times);
    % For each time range in parse_switch_out,
    for i = 2:size(parse_switch_out)
        % Get the data from that range and add it to our data vectors
        [window_concs, window_starts, window_ends] = get_entries_middle(parse_switch_out(i,1), parse_switch_out(i,2), bin_concentrations, start_times, end_times);
        filtered_concentrations = [filtered_concentrations; window_concs];
        filtered_start_times = [filtered_start_times; window_starts];
        filtered_end_times = [filtered_end_times; window_ends];
    end
end

% A helper function that does the filtering
function [ bin_concentrations_middle, start_times_middle, end_times_middle ] = get_entries_middle( split_timepoint_1, split_timepoint_2, bin_concentrations, start_times, end_times )
    bin_concentrations_middle = bin_concentrations((end_times < split_timepoint_2) & (start_times > split_timepoint_1),:);
    start_times_middle = start_times((end_times < split_timepoint_2) & (start_times > split_timepoint_1),:);
    end_times_middle = end_times((end_times < split_timepoint_2) & (start_times > split_timepoint_1),:);
end
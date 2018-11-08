format long g

% Parse data
[ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS_aggregated('SEMS Data/results');

% % Split data into a before and an after
% split_timepoint = datetime('15-Oct-2018 14:20:20');
% [ bin_concentrations_before, start_times_before, end_times_before ] = get_entries_before( split_timepoint, bin_concentrations, start_times, end_times );
% [ bin_concentrations_after, start_times_after, end_times_after ] = get_entries_after( split_timepoint, bin_concentrations, start_times, end_times );
% % Print number of scans before and after split time
% size(bin_concentrations_before)
% size(bin_concentrations_after)

% % Make up a matrix of datetimes and filter out data from that
% filtering_datetimes = [[datetime('15-Oct-2018 14:20:20'),datetime('15-Oct-2018 14:30:20')],[datetime('15-Oct-2018 14:40:20'), datetime('15-Oct-2018 14:50:20')]];
% [filtered_concentrations, filtered_start_times, filtered_end_times] = filter_concentrations(filtering_datetimes, bin_concentrations, start_times, end_times);
% 
% % Plot average concentrations
% % plt_avg_concentrations( bin_diameters, bin_concentrations_before, bin_concentrations_after )
% 
% % Plot concentrations
% plt_concentrations(bin_diameters, bin_concentrations_before, start_times_before )

% Parse switching data
[v1_ranges, v2_ranges] = parse_switching_file_with_cache('switching_logs/log131846254668719944.txt');
% Make the ranges a little bit shorter because it takes about 10 seconds
% for the old air in the pipe to completely flow through
v1_ranges(:,1) = v1_ranges(:,1) + seconds(40);
v2_ranges(:,1) = v2_ranges(:,1) + seconds(40);

% Filter based on switching data
[v1_concentrations, v1_starts, v1_ends] = filter_concentrations(v1_ranges, bin_concentrations, start_times, end_times);
[v2_concentrations, v2_starts, v2_ends] = filter_concentrations(v2_ranges, bin_concentrations, start_times, end_times);


% plot(v1_starts,  sum(v1_concentrations, 2), v2_starts, sum(v2_concentrations, 2))

plot_particle_count(v1_starts, v1_concentrations, v2_starts, v2_concentrations, bin_diameters);
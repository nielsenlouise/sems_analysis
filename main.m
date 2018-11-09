format long g

% Parse data
[ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS_aggregated('SEMS Data/results');


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

% Split data into a before and an after
split_timepoint = datetime('28-Oct-2018 10:45:00');

[ v1_concentrations_before, v1start_times_before, v1end_times_before ] = get_entries_before( split_timepoint, v1_concentrations, v1_starts, v1_ends );
[ v1_concentrations_after, v1start_times_after, v1end_times_after ] = get_entries_after( split_timepoint, v1_concentrations, v1_starts, v1_ends );

[ v2_concentrations_before, v2start_times_before, v2end_times_before ] = get_entries_before( split_timepoint, v2_concentrations, v2_starts, v2_ends );
[ v2_concentrations_after, v2start_times_after, v2end_times_after ] = get_entries_after( split_timepoint, v2_concentrations, v2_starts, v2_ends );


% plot(v1_starts,  sum(v1_concentrations, 2), v2_starts, sum(v2_concentrations, 2))

%% Plot average concentrations
subplot(2,1,1)
plt_avg_concentrations(bin_diameters,v1_concentrations_before, v2_concentrations_before)
legend('Indoor','Outdoor')
axis([-inf inf 0 7000])
subplot(2,1,2)
plt_avg_concentrations(bin_diameters,v1_concentrations_after, v2_concentrations_after)
axis([-inf inf 0 7000])

%% Plot pcolor plots
% plot_bananaplot(v1_starts, v1_concentrations, v2_starts, v2_concentrations, bin_diameters);

%% Plot particle count plots
% plot_particle_count(v1_starts, v1_concentrations, v2_starts, v2_concentrations, bin_diameters);

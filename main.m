format long g

[ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS('SEMS_140_RESULTS_181015_134310.dat');
split_timepoint = datetime('15-Oct-2018 14:20:20');
[ bin_concentrations_before, start_times_before, end_times_before ] = get_entries_before( split_timepoint, bin_concentrations, start_times, end_times );
[ bin_concentrations_after, start_times_after, end_times_after ] = get_entries_after( split_timepoint, bin_concentrations, start_times, end_times );
size(bin_concentrations_before)
size(bin_concentrations_after)


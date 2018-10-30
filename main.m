format long g

[ bin_concentrations, bin_diameters, start_times, end_times ] = parse_SEMS('SEMS_140_RESULTS_181015_134310.dat');
split_timepoint = datetime('15-Oct-2018 14:20:11');
[ output_args ] = split_time( split_timepoint,  bin_concentrations, start_times, end_times );
disp(output_args)


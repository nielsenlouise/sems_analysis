function plot_particle_count_ratio(start_times1, concentrations1, start_times2, concentrations2, bin_diameters)
% Plots particle count over time from inside and outside.
% bin_widths is in nm (we assume the bin diameter value is the max of the
%   bin and the minimum scan diameter is 0)
% We assume the units of the concentrations are: #particles/(micron * cm^3)
% Particle count per scan is the sum of all bin concentrations multiplied 
% by their respective widths (unit: particles/cubic cm). This is then 
% plotted against time.

    % Assuming bin diameters are maxes, and the minimum scan size is 0,
    bin_widths = diff(log([6 bin_diameters]/1000));
    
    particle_ct1 = (concentrations1 * bin_widths');
    particle_ct2 = (concentrations2 * bin_widths');
    
    m1 = movmean(particle_ct1, 100);
    m2 = movmean(particle_ct2, 100);
    
%     ratio = m2 ./ m1
    
    ratio = particle_ct2 ./ particle_ct1;
    
    nonempty_rows = find(~all(ratio==0,2));
    
    nonempty_ratio = ratio(nonempty_rows');
    nonempty_start_times = start_times1(nonempty_rows');
    
    add_filter_time = ('28-October-2018 10:45:00');
    
    plot(nonempty_start_times, nonempty_ratio)
%     set(gca, 'YScale', 'log')
    y1 = get(gca,'ylim');
    hold on
    plot(add_filter_time,y1)
    xlabel('Time')
    ylabel('Indoor/outdoor ratio')
end
function plot_particle_count(start_times1, concentrations1, start_times2, concentrations2, bin_diameters)
% Plots particle count over time from inside and outside.
% bin_widths is in nm (we assume the bin diameter value is the max of the
%   bin and the minimum scan diameter is 0)
% We assume the units of the concentrations are: #particles/(micron * cm^3)
% Particle count per scan is the sum of all bin concentrations multiplied 
% by their respective widths (unit: particles/cubic cm). This is then 
% plotted against time.

    % Assuming bin diameters are maxes, and the minimum scan size is 0,
    bin_widths = diff([0 bin_diameters]);
    
    particle_ct1 = (concentrations1 * bin_widths')./1000;
    particle_ct2 = (concentrations2 * bin_widths')./1000;
    
    plot(start_times1, particle_ct1, start_times2, particle_ct2)
    xlabel('Time')
    ylabel('Particles per cm^3')
    legend('Valve 1','Valve 2')
end
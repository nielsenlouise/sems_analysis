function plt_avg_concentrations( bin_diameters, bin_concentrations_before, bin_concentrations_after )
%plt_avg_concentrations plots average concentrations for each particle size
    plot(bin_diameters, mean(bin_concentrations_before), bin_diameters, mean(bin_concentrations_after))
    set(gca,'xscale','log')
    xlim([min(bin_diameters), max(bin_diameters)])
        
end


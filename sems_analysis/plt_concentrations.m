function plt_concentrations( bin_diameters, bin_concentrations, times )
% plt_concentrations plots all concentrations in the concentrations matrix
% based on times vector

figure('Name', 'Size distribution')
h2(1) = subplot(2,1,1);

timepoints = length(times);
cmap = colormap(jet(timepoints));
disp(times(end))
caxis('auto');
hold on
for i = 1:timepoints
    plot(bin_diameters, bin_concentrations(i,:), 'color', cmap(i,:))
end
hold off
box on
set(gca, 'xscale', 'log')
xlim([min(bin_diameters), max(bin_diameters)])
xlabel('D_p (nm)')
ylabel('dN/dlogD_p')
h2(2) = colorbar;
ylabel(h2(2),'Time')

hold on
plot(bin_diameters, mean(bin_concentrations),'k', 'LineWidth',2)
hold off

end
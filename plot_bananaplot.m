function plot_bananaplot(start_times1, concentrations1, start_times2, concentrations2, bin_diameters)
    %% Plot the first set of data
    subplot(2,1,1)
    h(1) = pcolor(datenum(start_times1), bin_diameters, concentrations1')
    
    shading interp
    set(gca,'yscale','log')
    set(gca,'YTick',[10,20,50,100,200,500,800,1000])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    
    axis([-inf 737364.277175926 -inf inf])
    
    h(2) = colorbar
    
    sums = sum(concentrations1);
    index = find(sums==max(sums));
    maxvector = concentrations1(:,index);
    mn = mean(maxvector);
    stdev2 = std(maxvector);
    maxconc = mn + 2*stdev2
    
    caxis([0 maxconc])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    mintime = min(datenum(start_times1));
    maxtime = max(datenum(start_times1));
    increment = 10*(maxtime-mintime)/length(datenum(start_times1));
    
    
%     NumTicks = 400;
%     L = get(gca,'XLim');
%     set(gca,'XTick',linspace(L(1),L(2),NumTicks))
%     datetick('x', 0, 'keepticks')
    
    %% Plot the second set of data
    subplot(2,1,2)
    h2(1) = pcolor(datenum(start_times2), bin_diameters, concentrations2')
    
    shading interp
    set(gca,'yscale','log')
    set(gca,'YTick',[10,20,50,100,200,500,800,1000])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    
    axis([-inf 737364.277175926 -inf inf])
    
    h2(2) = colorbar
    
    sums2 = sum(concentrations2);
    index2 = find(sums2==max(sums2));
    maxvector2 = concentrations2(:,index2);
    mn2 = mean(maxvector2);
    stdev2 = std(maxvector2);
    maxconc2 = mn + 2*stdev2
    
    caxis([0 maxconc2])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    mintime = min(datenum(start_times2));
    maxtime = max(datenum(start_times2));
    increment = 10*(maxtime-mintime)/length(datenum(start_times2));
    
    
%     NumTicks = 400;
%     L = get(gca,'XLim');
%     set(gca,'XTick',linspace(L(1),L(2),NumTicks))
%     datetick('x', 0, 'keepticks')

    
end
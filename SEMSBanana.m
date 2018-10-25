function SEMSBanana(filename,nscans,nbins,sizestart, maxconc)
% Things left to do: 1. make it flexible for different number of bins (does
% the math work out?; 2. kill maxconc and scale color automatically by the
% value at + 2SD

%% Instructions

% First, open '.dat' results file in Excel and: 1. delete preamble, 
%   2. ensure columns are all labled, 3. delete blank rows, 4. save '.csv'
% Then, open .csv file and load date and time

% File must be a .csv with no preamble information (header ok)
% INPUT VARIABLES:
% nscans = number of rows of file -1
% nbins = number of bins set in SEMS scan function
% sizestart = column that size midpoint data starts
% maxconc: set for max concentration in color bars; if set to < 100, the program
% will calculate a max concentration as a multiple of standard deviation
% Starts reading data after all state data and time (at column 21)

lastpoint = nbins*2+sizestart;
data = dlmread(filename,',', [1 sizestart nscans lastpoint]);
size(data)
data;

timedate = dlmread(filename,',', [1 6 nscans 12]);
Year = timedate(:,1);
Day = timedate(:,2);
Month = timedate(:,3);
Hour = timedate(:,4);
Minute = timedate(:,5);
Second = timedate(:,6);
datetime = datenum(Year,Month,Day,Hour,Minute,Second);
datetimes = datestr(datetime);

%% Set maximum in color bar plots to some multiple of standard deviations
if maxconc < 100
    sums = sum(data);
    index = find(sums==max(sums));
    maxvector = data(:,index);
    mn = mean(maxvector);
    stdev = std(maxvector);
    maxconc = mn + maxconc*stdev
end

%% Plotting cool stuff!
[l,w] = size(data);
Dp = data(2,:);
Dp = transpose(Dp);
Dp = Dp(2:nbins+1);
    %Number distribution waterfall and banana plots
    figure(2)
    h2(1) = subplot(2,1,1);
    timepoints = length(datetime);
    cmap = colormap(jet(timepoints));
    caxis([datetime(1) datetime(end)]); 
    numdist = data(:, nbins+2:w);
    hold on
    for i = 1:timepoints
        %plot(DMAdata.Dp(:,2),DMAdata.voldist_sus(i,:),'color',cmap(i,:))
        plot(Dp,numdist(i,:),'color',cmap(i,:))
    end
    hold off
    box on
    set(gca,'xscale','log')
    xlabel('D_p (nm)')
    xlim([5 200])
    ylabel('dN/dlogD_p')
    h2(2) = colorbar;
    %colorbar('TickLabels',[datetimes(1,1), datetimes(1,(length(datetimes)/2)), datetimes(1,(length(datetimes)))
    ylabel(h2(2),'Time')
 
    h2(3) = subplot(2,1,2);
    %bananah = bananaplot(datetime,Dp,numdist,maxconc); %check here for funky time scale stuff
    datetimess = string(datetimes);
%     LDT = length(datetime);
%     LDTS = length(datetimes);
%     maxdatetimes = datetimess(LDTS);
%     maxdatetime = datetime(LDT);
    
    h(1) = pcolor(datetime,Dp,numdist');
    shading interp
    set(gca,'yscale','log')
    set(gca,'YTick',[10,20,50,100,200,500,800,1000])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    h(2) = colorbar;
    caxis([0 maxconc])
    set(gca,'YTickLabel',{'10','20','50','100','200','500','800','1000'})
    mintime = min(datetime);
    maxtime = max(datetime);
    increment = 10*(maxtime-mintime)/length(datetime);
    %set(gca,'Xtick',mintime:increment:maxtime)
    %set(gca,'XTick',mintime:increment:maxtime);
    NumTicks = 400;
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x', 0, 'keepticks')
    %datetick('x', 0)
    set(gca,'layer','top')
    set(gca,'XMinorTick','on');
    
    %%
%     axbot = gca ;              %// retrieve the handle of the current axis
% set(axbot, 'XScale', 'log', 'YScale', 'log');
% axis off                   %// remove all ticks/grid etc...
% 
% %// now create the "overlay" axes, which replicate some of the properties of the underlying axis (position/limits etc ...)
% axtop = axes('Position',get(axbot,'Position'),'Color','none',...
%             'Xlim',get(axbot,'XLim'), 'Ylim',get(axbot,'YLim'),...
%             'XScale', 'log', 'YScale', 'log' , ...
%             'YMinorTick','on' , 'YMinorGrid','off') ;
%         datetick('x', 0,'keepticks')
        %%
    %set(gca,'XTickLabel',datetimess)
    xtickangle(90)
    xlabel('Time (hr)')
    ylabel('D_p (nm)')
    ylabel(h(2),'dN/dlogD_p')
  
end


%{
This is a model for the ADE Air Quality team, Fall 2018. 
    
    The model has a variety of things to change to fit theory as well as
    measured data. The differential equation for the change in indoor
    concentration is as follows:

    dC/dt = (S/V + Ca*n) - C*I - K * C

    The steady state version of this equation is 
    C(inf) = ((S/V) + Ca*I) / (I + k) 
%}

clear; clf;

% parameters

defineVariables;


% Concentration over time
%{
C = CvT(T,S,V,C,Ca,I,K,dt);
eq = (Ca*I)/(I + K);
plot(T(1:length(T)),C(1:length(T)));
hold on;
plot(T(1:length(T)),eq*ones(1,length(T)));
%}

%time to steady state vs I
%{
defineVariables;    % resets variable values



I = 1:.2:4;         %defines the range of infiltration rates
I = I/3600;         %changes the unit from ach to acs (air change second)

t2Eq = zeros(1,length(I));              %creates a variables for time to equilibrium
t2Eq = timeToEq(T,S,V,C,Ca,I,K,dt);     % runs function

plot(I*3600, t2Eq./3600);
xlabel('Infiltration rate in ach');
ylabel('Time to equilibrium in hours');
xlim([3600*I(1)-.2,3600*I(length(I))+.2]);

%}

% time to steady state vs I. Range of Ks
%{
defineVariables;
t2Eq = zeros(1,length(I)); %creates a variables for time to equilibrium
I = 1:.2:4;         %defines the range of infiltration rates
I = I/3600;         %changes the unit from ach to acs (air change second)
n = 1;
for i = 0:.1:.8
    
    dep = i/3600;                             % ach to acs
    t2Eq = timeToEq(T,S,V,C,Ca,I,dep,dt);     % runs function
    plot(I*3600, t2Eq./3600);
    legendInfo{n} = ['k = ' num2str(i)];
    n = n+1;
    hold on;
    
end
    legend(legendInfo);
    xlabel('Infiltration rate in ach');
    ylabel('Time to equilibrium in hours');
    xlim([3600*I(1)-.2,3600*I(length(I))+.2]);
    
  %}  
    
% HEATMAP of time to steady state for a particular ca. K vs I
%{
defineVariables;

Ca = 100000;

I = 1:.1:4;            % defines the range of infiltration rates
I = I/3600;             % changes the unit from ach to acs (air change second)
I = flip(I);
K = 0:.1:4;            % sets range of K values in 1/hr
K = K./3600;            % chages units to 1/s
t2Eq = zeros(length(I),length(K)); %creates a variables for time to equilibrium in hours

for i = 1:length(I)
    for k = 1:length(K)
    
        t2Eq(i,k) = timeToEq(T,S,V,C,Ca,I(i),K(k),dt)./3600;     % runs function

    end
end
    
    pcolor(K.*3600,I.*3600,t2Eq);
    colorbar;
    colormap jet;
    title('Time to Steady State');
    xlabel('K 1/hr, range:0 to 2');
    ylabel('infiltration rate in ach, range: 1 to 4');
%}

% HEATMAP of indoor equilibrium concentration for particular Ca. K vs I
%{
defineVariables;

Ca = 100000; 

I = 1:.1:4;            % defines the range of infiltration rates
I = I/3600;             % changes the unit from ach to acs (air change second)
I = flip(I);
K = 0:.1:4;            % sets range of K values in 1/hr
K = K./3600;            % chages units to 1/s
finalC = zeros(length(I),length(K)); %creates a variables for time to equilibrium in hours

for i = 1:length(I)
    for k = 1:length(K)
    
        finalC(i,k) = eqC(S,V,Ca,I(i),K(k));     % runs function

    end
end
  
    pcolor(K.*3600,I.*3600,finalC./Ca);
    colorbar;
    colormap jet;
    title('Concentration Ratio');
    xlabel('K 1/hr, range:0 to 2');
    ylabel('infiltration rate in ach, range: 1 to 4');
%}

% HEATMAP of K. C/Ca vs I
%{
defineVariables;

CRatio = 0.3:0.02:1;  %C/Ca. indoor steady state concentration over ambient concentration 
I = 1:.1:4;            % defines the range of infiltration rates
I = I/3600;             % changes the unit from ach to acs (air change second)
I = flip(I);
finalK = zeros(length(I),length(CRatio)); %creates a variables for K 

for i = 1:length(I)
    for k = 1:length(CRatio)
    
        finalK(i,k) = eqK(CRatio(k),I(i));     % runs function

    end
end

    pcolor(CRatio,I.*3600,finalK*3600);
    colorbar;
    colormap jet;
    title('k Value to Achieve Equilibrum');
    xlabel('C/Ca, Ratio of Indoor to Outdoor Concentration');
    ylabel('Infiltration Rate in ach');
%}




% infiltration matters less than decay rate. We want to target K, and
% for plumes, I almost doesn't matter
% document where the math came from
% make heatmap for K :  I vs C/Ca 


%define variables for the house model


dur = 60*3600;                  % seconds. duraction of modeling
dt = 1;                         % seconds time step
T = 1:dt:dur;                   % Time array. seconds 
C = zeros(1,dur/dt);            % #/cm^3 indoor concentration
Ca = 100000;                     % #/cm^3 outdoor concentration
S = 0;                          % #/min indoor source
V = 120*10^6;                   % cm^3 per air change
I = 3.1/3600;                   % # of air changes per minute
K =.48/3600;                    % 1/second pollution decay rate
% plot bowen ratio and SHF and LHF in control run

% times at which the Bowen ratio is defined
time = [0,1440,23400,27000,36000,45000];

% times at which the surface fluxes are presecribed 
time_fluxes = [0,1440,23400,27000,36000,45000, 52200];

% from spreadsheet 
bowen = [-2,0.36,0.311111,0.28,0.2381,0.00556];
SHF = [-10, 90, 140, 140, 100, 1, -10];
LHF = [5, 250, 450, 500, 420, 180, 0];

% initialise plots 
hold off; 
t=tiledlayout(1,2);

nexttile; 
hold off; 

% plot timeseries for the sensible and latent heat fluxes 
plot_2 = plot(time_fluxes, SHF, ...
    'DisplayName','Sensible', ...
    'Color','red',...
    'LineWidth', 2);
hold on; 
plot_3 = plot(time_fluxes, LHF, ...
    'DisplayName','Latent', ...
    'Color', 'blue',...
    'LineWidth', 2, ...
    'LineStyle','-');

% plot line at y=0
yline(0)

% set axis labels title, sclae 
ylabel('Flux [W/m2]', 'Color','k')
xlabel('Time since start of simulation [s]')
xlim([0,55000]);
title('a. Surface fluxes');
legend([plot_2,plot_3]);
ylim([-50, 510])

nexttile;

% plot Bowen ratio over time 
plot_1 = plot(time, bowen, ...
    'Color', 'k', ...
    'LineWidth', 3, ...
    'DisplayName','Bowen Ratio');
% add y axis for reference 
yline(0)

% set limits, titles, axes and labels 
ylim([-2,2])
ylabel('Bowen Ratio', 'Color','k')
xlabel('Time since start of simulation [s]')
legend(plot_1);
xlim([0,55000]);
title('b. Bowen Ratio')


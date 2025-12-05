% script to generate vertical profiles of either LES or 1DBL data 
% ensure files plot_data_1dbl.m and plot_data_les.m are in the working
% directory, otherwise code will not work ! 

%% set directory paths 

% working directory, where code is 
%cd "[path to your directory]"

% directory where the LES data is stored
% change directory location if needed 
indir_les = "arm_les_monc_50m\";

% directory where the 1DBL output data is stored 
indir_1dbl = "output\";

hold off;

%% plot 1DBL data 

% function takes parameters: 
% plot_data_1dbl(indir_les, [time to plot], [plotting variable], [specify
% x limits?], [lower x limit], [upper x limit], [upper y limit])

% variable name must be from list th, u, v, qv, ql, p, rh, uw, uv, k_m or
% k_h otherwise code will throw an error 

% if specify x limits = false, still need  to enter upper and lower x
% limits when calling function, they will be ignored though

% otherwise, if specify x limits? = true, then they will be used 

%% plot LES data 

% plot_data_les(indir_les, [time to plot], [plotting variable], [specify
% x limits?], [lower x limit], [upper x limit], [upper y limit])

%% run lines below to generate figure for sensitivity tests  
% plot_data_1dbl(indir_1dbl_ratio_changes+"\output_01\", 2400, "wth", false, 301, 315, 2000, true, ", output 01");
% hold on;
% plot_data_1dbl(indir_1dbl_ratio_changes+"\output_02\", 2400, "wth", false, 301, 315, 2000, true, ", output 02");
% plot_data_1dbl(indir_1dbl_ratio_changes+"\output_03\", 2400, "wth", false, 301, 315, 2000, true, ", output 03");
% plot_data_1dbl(indir_1dbl_ratio_changes+"\output_04\", 2400, "wth", false, 301, 315, 2000, true, ", output 04");
% plot_data_1dbl(indir_1dbl_ratio_changes+"\output_05\", 2400, "wth", false, 301, 315, 2000, true, ", output 05");


%% run code below to generate figure showing the evolution of the 1DBL in our model 
% % hold on ;
% t = tiledlayout(2,2);
% nexttile;
% plot_data_1dbl(indir_1dbl, 1200, "th", false, 301, 315, 5, false, '', '-', 'k'); 
% hold on
% plot_data_1dbl(indir_1dbl, 13200, "th", false, 301, 315, 5, false, '', '--', 'k'); 
% plot_data_1dbl(indir_1dbl, 25200, "th", false, 301, 315, 5, false, '', '-.', 'k'); 
% plot_data_1dbl(indir_1dbl, 37200, "th", false, 301, 315, 5, false, '', ':', '#00468b'); 
% plot_data_1dbl(indir_1dbl, 49200, "th", false, 301, 315, 5, false, '', '-', '#00468b');
% title('Potential temperature')
% ylim([0,2250]) ;
% %legend('Location','northwest');
% 
% nexttile;
% plot_data_1dbl(indir_1dbl, 1200, "wth", false, 301, 315, 5, false, '', '-', 'k'); 
% hold on
% plot_data_1dbl(indir_1dbl, 13200, "wth", false, 301, 315, 5, false, '', '--', 'k'); 
% plot_data_1dbl(indir_1dbl, 25200, "wth", false, 301, 315, 5, false, '', '-.', 'k'); 
% plot_data_1dbl(indir_1dbl, 37200, "wth", false, 301, 315, 5, false, '', ':', '#00468b'); 
% plot_data_1dbl(indir_1dbl, 49200, "wth", false, 301, 315, 5, false, '', '-', '#00468b');
% title('Heat flux')
% ylim([0,2250]) ;
% legend('Location','northeast');
% 
% nexttile;
% plot_data_1dbl(indir_1dbl, 1200, "qv", false, 301, 315, 5, false, '', '-', 'k'); 
% hold on
% plot_data_1dbl(indir_1dbl, 13200, "qv", false, 301, 315, 5, false, '', '--', 'k'); 
% plot_data_1dbl(indir_1dbl, 25200, "qv", false, 301, 315, 5, false, '', '-.', 'k'); 
% plot_data_1dbl(indir_1dbl, 37200, "qv", false, 301, 315, 5, false, '', ':', '#00468b'); 
% plot_data_1dbl(indir_1dbl, 49200, "qv", false, 301, 315, 5, false, '', '-', '#00468b');
% title('Water vapour mixing ratio')
% ylim([0,2250]) ;
% % legend('Location','northeast');
% 
% nexttile;
% plot_data_1dbl(indir_1dbl, 1200, "uw", false, 301, 315, 5, false, '', '-', 'k'); 
% hold on
% plot_data_1dbl(indir_1dbl, 13200, "uw", false, 301, 315, 5, false, '', '--', 'k'); 
% plot_data_1dbl(indir_1dbl, 25200, "uw", false, 301, 315, 5, false, '', '-.', 'k'); 
% plot_data_1dbl(indir_1dbl, 37200, "uw", false, 301, 315, 5, false, '', ':', '#00468b'); 
% plot_data_1dbl(indir_1dbl, 49200, "uw", false, 301, 315, 5, false, '', '-', '#00468b');
% title('Momentum flux, uw')
% ylim([0,2250]) ;
% % legend('Location','northwest');
% t.Padding = ['compact'];
% t.TileSpacing = 'compact';




%% run lines below to generate figure 1DBL/ LES comparison for paper 
% t= tiledlayout(2,3);
% nexttile
% plot_data_les(indir_les, 1200, "th", false, 301, 315, 3000, '#8B0000', '-.'); 
% hold on;
% plot_data_1dbl(indir_1dbl, 1200, "th", true, 298, 315, 5, false, '', '-', '#00468b'); 
% title('0:20 [h:min]');
% 
% nexttile
% plot_data_les(indir_les, 13200, "th", false, 301, 315, 3000, '#8B0000', '-.'); 
% hold on ;
% plot_data_1dbl(indir_1dbl, 13200, "th", true, 298, 315, 5, false, '', '-', '#00468b'); 
% title('3:39')
% 
% nexttile 
% plot_data_les(indir_les, 25200, "th", false, 301, 315, 3000, '#8B0000', '-.'); 
% hold on; 
% plot_data_1dbl(indir_1dbl, 25200, "th", true, 298, 315, 5, false, '', '-', '#00468b'); 
% title('7:00');
% 
% nexttile
% plot_data_les(indir_les, 37200, "th", false, 301, 315, 3000, '#8B0000', '-.'); 
% hold on; 
% plot_data_1dbl(indir_1dbl, 37200, "th", true, 298, 315, 5, false, '', '-', '#00468b'); 
% title('10:20');
% 
% nexttile; 
% plot_data_les(indir_les, 49200, "th", false, 301, 315, 3000, '#8B0000', '-.');
% hold on; 
% plot_data_1dbl(indir_1dbl, 49200, "th", true, 298, 315, 5, false, '', '-', '#00468b');
% title('13:39');
% 
% nexttile; 
% plot_data_les(indir_les, 51600, "th", false, 301, 315, 3000, '#8B0000', '-.');
% hold on; 
% plot_data_1dbl(indir_1dbl, 51600, "th", true, 298, 315, 5, false, '', '-', '#00468b');
% title('14:18');
% legend('Location', 'northwest');
% title(t, 'Potential Temperature Profiles')

%% run code below to make tiled layout of heat flux 
t= tiledlayout(2,3);
nexttile
plot_data_les(indir_les, 1200, "wth", false, 301, 315, 3000, '#8B0000', '-.'); 
hold on;
plot_data_1dbl(indir_1dbl, 1200, "wth", false, 301, 315, 5, false, '', '-', '#00468b'); 
title('0:20 [h:min]');

nexttile
plot_data_les(indir_les, 13200, "wth", false, 301, 315, 3000, '#8B0000', '-.'); 
hold on ;
plot_data_1dbl(indir_1dbl, 13200, "wth", false, 301, 315, 5, false, '', '-', '#00468b'); 
title('3:39')

nexttile 
plot_data_les(indir_les, 25200, "wth", false, 301, 315, 3000, '#8B0000', '-.'); 
hold on; 
plot_data_1dbl(indir_1dbl, 25200, "wth", false, 301, 315, 5, false, '', '-', '#00468b'); 
title('7:00');

nexttile
plot_data_les(indir_les, 37200, "wth", false, 301, 315, 3000, '#8B0000', '-.'); 
hold on; 
plot_data_1dbl(indir_1dbl, 37200, "wth", false, 301, 315, 5, false, '', '-', '#00468b'); 
title('10:20');

nexttile; 
plot_data_les(indir_les, 49200, "wth", false, 301, 315, 3000, '#8B0000', '-.');
hold on; 
plot_data_1dbl(indir_1dbl, 49200, "wth", false, 301, 315, 5, false, '', '-', '#00468b');
title('13:39');

nexttile; 
plot_data_les(indir_les, 51600, "wth", false, 301, 315, 3000, '#8B0000', '-.');
hold on; 
plot_data_1dbl(indir_1dbl, 51600, "wth", false, 301, 315, 5, false, '', '-', '#00468b');
title('14:18');
legend('Location', 'northwest');
title(t, 'Heat Flux Profiles')

% %% run code below to see tiled layout of water vapour mixing ratio
% t= tiledlayout(2,3);
% nexttile
% plot_data_les(indir_les, 1200, "qv", true, 0, 25, 3000, '#8B0000', '-.'); 
% hold on;
% plot_data_1dbl(indir_1dbl, 1200, "qv", false, 301, 315, 5, false, '', '-', '#00468b'); 
% title('0:20 [h:min]');
% 
% nexttile
% plot_data_les(indir_les, 13200, "qv", true, 0, 25, 3000, '#8B0000', '-.'); 
% hold on ;
% plot_data_1dbl(indir_1dbl, 13200, "qv", false, 301, 315, 5, false, '', '-', '#00468b'); 
% title('3:39')
% 
% nexttile 
% plot_data_les(indir_les, 25200, "qv", true, 0, 25, 3000, '#8B0000', '-.'); 
% hold on; 
% plot_data_1dbl(indir_1dbl, 25200, "qv", false, 301, 315, 5, false, '', '-', '#00468b'); 
% title('7:00');
% 
% nexttile
% plot_data_les(indir_les, 37200, "qv", true, 0, 25, 3000, '#8B0000', '-.'); 
% hold on; 
% plot_data_1dbl(indir_1dbl, 37200, "qv", false, 301, 315, 5, false, '', '-', '#00468b'); 
% title('10:20');
% 
% nexttile; 
% plot_data_les(indir_les, 49200, "qv", true, 0, 25, 3000, '#8B0000', '-.');
% hold on; 
% plot_data_1dbl(indir_1dbl, 49200, "qv", false, 301, 315, 5, false, '', '-', '#00468b');
% title('13:39');
% 
% nexttile; 
% plot_data_les(indir_les, 51600, "qv", true, 0, 25, 3000, '#8B0000', '-.');
% hold on; 
% plot_data_1dbl(indir_1dbl, 51600, "qv", false, 301, 315, 5, false, '', '-', '#00468b');
% title('14:18');
% legend('Location', 'northeast');
% title(t, 'Water Vapor Mixing Ratio Profiles')





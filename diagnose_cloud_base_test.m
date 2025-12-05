%% use complete data frame to dianose cloud base from data 
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
indir_1dbl_ratio_changes = "Outputs\Ratio_changes\";
indir_1dbl_ratio_constant = "Outputs\Ratio_constant\";

%% load the data
df = load_complete_df(indir_1dbl);
lesdf = load_les_df(indir_les); 

hold off;
time_vect = 1200:1200:51600;

% store info about height of cloud base in vector 
h_cl_rh = zeros(1,length(time_vect));
h_cl_rh_top = zeros(1,length(time_vect));
h_cl_rh_all = zeros(1,length(time_vect));
h_bl_wth = zeros(1,length(time_vect));
h_bl_top_wth = zeros(1,length(time_vect));
h_cl_lcl_bolton = zeros(1,length(time_vect));
h_cl_lcl_romps = zeros(1,length(time_vect));
les_h_cl_lcl_bolton = zeros(1,length(time_vect));
les_h_cl_lcl_romps = zeros(1,length(time_vect));
les_cl_frac = zeros(1,length(time_vect));
les_h_bl_top_wth = zeros(1, length(time_vect));
th_surf = load_global_par(indir_1dbl, "th_surf");
time_lab_vect = {};

%%5 loop over times, generate max value and plot 
k=1;
for curtime = time_vect

    % load data at correct time 
    rh_vect = df.rh(df.time==curtime);
    rh_top_vect = df.rh(df.time==curtime);
    rh_vect_all = df.rh(df.time==curtime);
    wth_vect = df.wth(df.time==curtime);
    zn_vect = df.zn(df.time==curtime);
    qv_vect = df.qv(df.time==curtime);
    p_vect = df.p(df.time==curtime);
    th_vect = df.th(df.time==curtime);

    les_rh_vect = lesdf.rh(lesdf.time==curtime);
    les_zn_vect = lesdf.zn(lesdf.time==curtime);
    les_qv_vect = lesdf.qv(lesdf.time==curtime);
    les_p_vect = lesdf.p(lesdf.time==curtime);
    les_th_vect = lesdf.th(lesdf.time==curtime);
    les_wth_vect = lesdf.wth(lesdf.time==curtime);
    les_clf_vect = lesdf.lclf(lesdf.time==curtime);

    T = th_vect(1);
    lesT = les_th_vect(1);
    qv = qv_vect(1);
    lesqv = les_qv_vect(1);
    p = p_vect(1);
    lesp = les_p_vect(1);


%   for diagnostics using relative humidity 
    if max(rh_vect) == 1
        h_cl_rh_top(k) = zn_vect(find(rh_vect==max(rh_vect), 1, 'last'));
        h_cl_rh(k) = zn_vect(find(rh_vect==max(rh_vect), 1));
    end 

    % taking maximum of relative humidity
    h_cl_rh_all(k) = zn_vect(find(rh_vect==max(rh_vect), 1));

    % diagnostic based on heat flux 
    h_bl_wth(k) = zn_vect(find(wth_vect==min(wth_vect), 1)); 

    % lowest layer where tclf is greater than 0
    if all(les_clf_vect == 0)
        les_cl_frac(k) = 0;
    else
        les_cl_frac(k) = les_zn_vect(find((les_clf_vect>0)&(les_zn_vect)>0 , 1));
    end 

    %% diagnose cloud base using Bolton 1980
    h_cl_lcl_bolton(k) = calc_cloud_base_bolton( ...
        qv, ...
        T, ...
        rh_vect(1), ...
        p)  ; 

    les_h_cl_lcl_bolton(k) = calc_cloud_base_bolton( ...
        lesqv, ...
        lesT, ...
        les_rh_vect(1), ...
        lesp)  ; 

    %% diagnose cloud base using Romps 2017
    h_cl_lcl_romps(k) = calc_cloud_base_romps( ...
        qv, ...
        T, ...
        rh_vect(1), ...
        p)  ; 

    les_h_cl_lcl_romps(k) = calc_cloud_base_romps( ...
        lesqv, ...
        lesT, ...
        les_rh_vect(1), ...
        lesp)  ; 

    % set time label 
    time_lab_vect{k} = string(floor(curtime/3600))+":"+string(60*((curtime/3600)-floor(curtime/(3600))));

    k = k+1;
end
% 

% set up layout of figures 
t = tiledlayout(2,1);
nexttile

% plot Bolton 
plot(time_vect, ...
    h_cl_lcl_bolton, ...
    'Linewidth', 2, ...
    'Displayname', 'LCL, Bolton 1980', ...
    'Color', 'blue', ...
    'LineStyle',':');
hold on ; 

% plot Romps 
plot(time_vect, ...
    h_cl_lcl_romps, ...
    'Linewidth', 2, ...
    'Displayname', 'LCL, Romps 2017', ...
    'Color', 'blue', ...
    'LineStyle','-');

% plot LES Bolton
plot(time_vect, ...
    les_h_cl_lcl_bolton, ...
    'Linewidth', 2, ...
    'Displayname', 'LES LCL, Bolton 1980', ...
    'Color', 'red', ...
    'LineStyle',':');

% plots LES Romps 
plot(time_vect, ...
    les_h_cl_lcl_romps, ...
    'Linewidth', 2, ...
    'Displayname', 'LES LCL, Romps 2017', ...
    'Color', 'red', ...
    'LineStyle','-');

% set axes, labels, title, limits and legend 
xlabel('Time [s]');
ylabel('Height [m]');
title('1. Evolution of LCL in LES and 1DBL')
xticks([3600:3600:51600]);
xticklabels(time_lab_vect(3:3:end));
xlabel("Time since start of simulation [h:min]");
legend('Location','northeastoutside');
title(t, 'Cloud diagnostics')

nexttile 
% plot LCL, Romps 
plot(time_vect, ...
    h_cl_lcl_romps, ...
    'Linewidth', 2, ...
    'Displayname', 'LCL, Romps 2017', ...
    'Color', 'blue', ...
    'LineStyle','-');

hold on; 
% plot boundary layer height of 1DBL
plot_global_par(indir_1dbl, "h_bl", 'Boundary layer height');

% plot cloud fraction from LES 
plot(time_vect, ...
    les_cl_frac, ...
    'Linewidth', 2, ...
    'Displayname', 'LES Cloud Fraction', ...
    'Color', 'r', ...
    'LineStyle','-');

% load in h_bl and h_cl to calcualte time of cloud formation 
h_bl = load_global_par(indir_1dbl, 'h_bl');
cl_h = load_global_par(indir_1dbl, 'cl_h');

% add vertical lines to show time of cloud formation 
xline(calc_time_of_clouds(h_bl, cl_h), 'b-.', 'LineWidth', 1.5, 'Displayname', 'Est. time of cloud formation, 1DBL');
xline(time_vect(find(les_cl_frac>0,1)), 'r-.', 'LineWidth', 1.5, 'Displayname', 'Est. time of cloud formation, LES');

% set axes, limits, labels, title and legend
xlabel('Time [s]');
ylabel('Height [m]');
title('2. Estimating time of cloud formation');
xticks(3600:3600:51600);
xticklabels(time_lab_vect(3:3:end));
xlabel("Time since start of simulation [h:min]");
legend('Location','northeastoutside');


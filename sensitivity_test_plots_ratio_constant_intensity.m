%% script to generate plots showing the diurnal cycle of the ABL in sensitivity tests 

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

%% make comparison plots with constant Bowen ratio but different intensities

ratio_constant = false ;
if ratio_constant 
    hold off; 

    % set labels 
    percent_vect = {'60%', '80%', '90%', 'control', '110%', '120%', '140%'};
    
    % loop over labels and plot water flux 
    for ii = 1:7
        plot_global_par(strcat(indir_1dbl_ratio_constant,"output_0",string(ii),"\"), ...
            'wq', ...
            percent_vect{ii});
        hold on; 
    end 
    legend();
end 

%% cloud base height using lcl, ratio changes 
cloud_base = true ;

% set tiled layout so all plots are on the same figure 
t=tiledlayout(2,2);
% plot over first column 
nexttile([2 1])

if cloud_base 
    hold off; 

    % set labels 
    percent_vect = {'60%', '80%', '90%', 'control', '110%', '120%', '140%'};

    k=1;
    % initialise vectors 
    max_blh = []; 
    cloud_time = [];
    
    % loop over labels and plot at each percentage 
    for ii = 1:length(percent_vect)
    
        % set directory and load data for current run 
        curdir = strcat(indir_1dbl_ratio_constant,"output_0",string(ii),"\");
        df = load_complete_df(curdir); 
    
        % set time 
        time_vect = 1200:1200:51600;
        
        % store info about height of cloud base in vector 
        h_cl_rh = zeros(1,length(time_vect));
        h_cl_lcl_bolton = zeros(1,length(time_vect));
        h_cl_lcl_romps = zeros(1,length(time_vect));
       time_lab_vect = {};
        
        % loop over times, generate max value and plot 
        k=1;
        for curtime = time_vect
            rh_vect = df.rh(df.time==curtime);
            zn_vect = df.zn(df.time==curtime);
            qv_vect = df.qv(df.time==curtime);
            p_vect = df.p(df.time==curtime);
            th_vect = df.th(df.time==curtime);
       
            % take first atmospheric layer 
            T = th_vect(1);
            qv = qv_vect(1);
            p = p_vect(1);
      
         
            % diagnose cloud base using Romps 2017
            h_cl_lcl_romps(k) = calc_cloud_base_romps( ...
                qv, ...
                T, ...
                rh_vect(1), ...
                p)  ; 
    
            % set time label 
            time_lab_vect{k} = string(floor(curtime/3600))+":"+string(60*((curtime/3600)-floor(curtime/(3600))));
            k = k+1;
        end 

        % plot the LCL using Romps 2017
         plot(time_vect, ...
            h_cl_lcl_romps, ...
            'Linewidth', 2, ...
            'Displayname', percent_vect{ii}, ...
            'LineStyle','-');
        hold on; 

        % take maximum cloud base height 
        max_blh(ii) = max(h_cl_lcl_romps); 

        % estimate time of cloud formation 
        cloud_time(ii) = calc_time_of_clouds(load_global_par(curdir, 'h_bl'), load_global_par(curdir, 'cl_h'));
    end 
    
    % set axes, labels, title and legend 
    xlabel('Time [s]');
    ylabel('Height [m]');
    xticks(3600:3600:51600);
    xticklabels(time_lab_vect(3:3:end));
    xlabel("Time since start of simulation [h:min]");
    title('1. Evolution of LCL');
    legend('Location','southeast');


    % ------------ plot maximum cloud base height ?
    max_cloud_base = true;
    if max_cloud_base 
        hold off; 
        nexttile;

        % plot the maximum boundary layer height against multiplier 
        plot([60,80,90,100,110,120,140], max_blh, ...
            'marker' ,'x', ...
            'MarkerSize', 5, ...
            'Linewidth', 2,'Color','k')

        % set axis labels, title 
        xlabel('Percentage of fluxes [%]');
        ylabel('Height [m]');
        title('2. Theoretical maximum cloud base height');
    end 

    % ------------ plot time clouds appear ?
    time_of_clouds = true;
    if time_of_clouds 
        hold off; 
        nexttile;

        % plot time of cloud formation against multiplier 
        plot([60,80,90,100,110,120,140], cloud_time, ...
            'marker' ,'x', ...
            'MarkerSize', 5, ...
            'Linewidth', 2,'Color','k')

        % set axis labels, title 
        xlabel('Percentage of fluxes [%]');
        ylabel('Time of cloud formation [s]');
        title('3. Time of cloud formation');
    
    end 
end 




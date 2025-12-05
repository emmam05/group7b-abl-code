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
indir_1dbl_init_qv = "Outputs\InitialMoistureProfile\";

%% cloud base height using lcl, ratio changes 
cloud_base = true ;
t=tiledlayout(2,2);
nexttile([2 1])

if cloud_base 
    hold off; 

    % set labels for the plot 
    percent_vect = {'10%', '20%', '40%', '60%', '80%', 'control', '120%', '140%', '160%', '180%', '200%'};
    k=1;
    
    % initilaise vectors 
    max_blh = []; 
    cloud_time = [];
    
    % loop labels and plot each one 
    for ii = 1:length(percent_vect)
    
        % set directory name 
        if ii < 10
            curdir = strcat(indir_1dbl_init_qv,"output_0",string(ii),"\");
        else 
            curdir = strcat(indir_1dbl_init_qv,"output_",string(ii),"\");
        end 

        % load data and set initial time 
        df = load_complete_df(curdir);
        time_vect = 1200:1200:51600;
        
        % store info about height of cloud base in vector 
        h_cl_rh = zeros(1,length(time_vect));
        h_cl_lcl_bolton = zeros(1,length(time_vect));
        h_cl_lcl_romps = zeros(1,length(time_vect));
       time_lab_vect = {};
        
        % loop over times, generate max value and plot 
        k=1;
        for curtime = time_vect

            % extract current time data from complete data frame 
            rh_vect = df.rh(df.time==curtime);
            zn_vect = df.zn(df.time==curtime);
            qv_vect = df.qv(df.time==curtime);
            p_vect = df.p(df.time==curtime);
            th_vect = df.th(df.time==curtime);
       
            % get data at the first level of the atmosphere
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

        % plot the lcl for the current water vapour percentage 
         plot(time_vect, ...
            h_cl_lcl_romps, ...
            'Linewidth', 2, ...
            'Displayname', percent_vect{ii}, ...
            'LineStyle','-');
        hold on; 

        % use romps to find the theoretical maximum clouds base 
        max_blh(ii) = max(h_cl_lcl_romps); 

        % celculate the time that clouds form 
        time_clouds = calc_time_of_clouds(load_global_par(curdir, 'h_bl'), load_global_par(curdir, 'cl_h'));

        % higher percentages immediately form clouds at ground level
        if (ii>5) & (time_clouds>44400) 
            cloud_time(ii) = 2383.1;
        else 
            cloud_time(ii) = time_clouds;
        end 
    end 
    
    % plot boundary layer height too 
    plot(time_vect, load_global_par(curdir, 'h_bl'), ...
        'Color', 'k', ...
        'LineStyle', ':', ...
        'LineWidth', 2, ...
        'DisplayName', 'BLH')

    % set axes, labels, legend and title 
    xlabel('Time [s]');
    ylabel('Height [m]');
    xticks(3600:3600:51600);
    xticklabels(time_lab_vect(3:3:end));
    xlabel("Time since start of simulation [h:min]");
    title('1. Evolution of LCL');
    legend('Location','southeastoutside');
    

    % ------------ plot maximum cloud base height ?
    max_cloud_base = true;
    if max_cloud_base 
        hold off; 
        nexttile;

        % plot the maxiumum theoretical cloud base height 
        plot([10,20,40,60,80,100,120,140,160,180,200], max_blh, ...
            'marker' ,'x', ...
            'MarkerSize', 5, ...
            'Linewidth', 2, ...
            'Color','k')

        % set axis labels and title 
        xlabel('Percentage of control run qv [%]');
        ylabel('Height [m]');
        title('2. Theoretical maximum cloud base height vs qv');
    end 

    % ------------ plot time clouds appear ?
    time_of_clouds = true;
    if time_of_clouds 
        hold off; 
        nexttile;
        plot([60,80,100,120,140,160,180,200], cloud_time(4:end), ...
            'marker' ,'x', ...
            'MarkerSize', 5, ...
            'Linewidth', 2, ...
            'Color','k')

        % set axis labels and title 
        xlabel('Percentage [%]');
        ylabel('Time of cloud formation [s]');
        title('3. Time of cloud formation vs qv');
    end
    title(t, 'Effect of initial moisture availability')
end 



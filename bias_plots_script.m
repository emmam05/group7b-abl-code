% script to plot bias of different variables 
% working directory, where code is 
%cd "[path to your directory]"

% directory where the LES data is stored
% change directory location if needed 
indir_les = "arm_les_monc_50m\";

% directory where the 1DBL output data is stored 
indir_1dbl = "output\";

%% load data

our_data = load_complete_df(indir_1dbl);
les_data = load_les_df(indir_les);


% make plots 
plot_bias_th(our_data, les_data, 1200:12000:51600)
plot_bias_wth(our_data, les_data, 1200:12000:51600)
plot_bias_qv(our_data, les_data, 1200:12000:51600)

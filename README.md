This repo contains the code used during group 7B's project: '1DBL: a single-column model for the numerical modelling of the atmospheric boundary layer'

The code here can be used to recreate the figures and analysis from our final report and presentation. 

## Data wrangling 
load_les_df.m 
- loads the LES data and converts it into a tabular format 
load_complete_df.m
- loads the height-dependent 1DBL data, cleans the data and returns the data in a tabular format
load_global_par.m
- loads the global parameters from 1DBL data (surface  fluxes, surface temperature etc...)

## Plotting model output  
plot_vertical_profiles.m
- reproduces report figures that show vertical profiles of atmospheric variables
plot_control_bowen_fluxes.m
- reproduces the figure in our report that shows the diurnal cycle of surface fluxes and Bowen ratio
plot_bias_[var].m
- function to plot the error of a given variable in our model over vertical height
bias_plots_script.m
- reporduces the figures that show error in our model in the report
  
## Calculating LCL, time of cloud formation 
calc_cloud_base_bolton.m 
- uses the method from Bolton et al. 1980 to calcualte the LCL from our model output
calc_cloud_base_romps.m
- uses the method from Romps et al. 2017 to calcualte the LCL from our model output
calc_time_of_clouds.m
- estimate the time at which the Boundary Layer Height meets the LCL
diagnose_cloud_base_test.m
- reproduces the figure in our paper that shows the evolution of the BLH and LCL, and how we estimated the time of cloud formation from this

## Sensitivity Tests 
sensitivity_tests_plots_init_qv2.m
- reproduces the figure in our report showing the results of the sensitivty tests on the initial moisture profile
sensitivity_tests_plots_init_ratio_constant_intensity.m
- reproduces the figure in our report showing the results of the sensitivty tests on the intensity of surface fluxes 
  
## Interactive suite 
The selection of Jupyter Notebooks can be used to access our interactive suite. 
The required packages for running the code are found in the file 'interactive_packages.yml'.
We set up a virtual environment using conda in which to run the Notebooks. 
'interactive_1dbl.ipynb' is the original file, and will produce the suite shown in our report. 



#Data from http://doi.org/10.5281/zenodo.1182665

wget https://zenodo.org/record/1182665/files/md-CHARMM36_POPS_POPC_Na_298K_10A-switch_v1_400-500ns_skip10.xtc
wget https://zenodo.org/record/1182665/files/for-md-CHARMM36_POPS_POPC_Na_298K_10A-switch_v1.tpr
mv md-CHARMM36_POPS_POPC_Na_298K_10A-switch_v1_400-500ns_skip10.xtc run.xtc
mv for-md-CHARMM36_POPS_POPC_Na_298K_10A-switch_v1.tpr run.tpr

sh order_parameters_calculatePOPC.sh
sh order_parameters_calculatePOPS.sh

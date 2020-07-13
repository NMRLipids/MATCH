# Data from https://doi.org/10.5281/zenodo.3605385

#wget https://zenodo.org/record/3605386/files/pcpe_slipids.xtc
#wget https://zenodo.org/record/3605386/files/pcpe_slipids.tpr
#wget https://zenodo.org/record/3605386/files/pcpe_slipids.gro

%mv pcpe_slipids.gro conf.gro
%mv pcpe_slipids.tpr topol.tpr
%echo System | gmx trjconv -f pcpe_slipids.xtc -s topol.tpr -o traj.xtc -b 100000


cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_slipids_POPC_all.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_Slipids_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

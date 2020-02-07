# Data from http://doi.org/10.5281/zenodo.3613573

#wget https://zenodo.org/record/3613573/files/PCPG_CA0.xtc
#wget https://zenodo.org/record/3613573/files/PCPG_CA0.tpr
#wget https://zenodo.org/record/3613573/files/PCPG_CA0.gro

mv PCPG_CA0.tpr topol.tpr
echo System | gmx trjconv -f PCPG_CA0.xtc -o traj.xtc -s topol.tpr -b 100000
mv PCPG_CA0.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_slipids_POPC_all.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

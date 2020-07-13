#Data from https://doi.org/10.5281/zenodo.3606439

#wget https://zenodo.org/record/3613573/files/PCPG_CA500_extend.xtc
#wget https://zenodo.org/record/3606440/files/PCPG_CA500.tpr
#wget https://zenodo.org/record/3606440/files/PCPG_CA500.gro

mv PCPG_CA500.tpr topol.tpr
echo System | gmx trjconv -f PCPG_CA500_extend.xtc -o traj.xtc -s topol.tpr -b 1000000
mv PCPG_CA500.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_slipids_POPC_all.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

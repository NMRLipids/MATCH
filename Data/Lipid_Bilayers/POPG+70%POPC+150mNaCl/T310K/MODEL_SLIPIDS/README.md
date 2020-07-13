#Original data from https://zenodo.org/record/2581186#.XK8_bEN7mHl



wget  https://zenodo.org/record/2581186/files/dm_popc_popg_7_3_slipid.xtc
wget  https://zenodo.org/record/2581186/files/md_07.tpr
wget 

mv  md_07.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popc_popg_7_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPIDS_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  dm_popc_popg_7_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPIDS_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat


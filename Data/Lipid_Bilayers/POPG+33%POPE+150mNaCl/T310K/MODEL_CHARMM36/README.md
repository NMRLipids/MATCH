#Original data from https://zenodo.org/record/2580153#.XKy_N0N7mHk



wget  https://zenodo.org/record/2580153/files/dm_popg_pope_3_1_charmm.xtc
wget  https://zenodo.org/record/2580153/files/md_03.tpr
wget 

mv  md_03.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popg_pope_3_1_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  dm_popg_pope_3_1_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


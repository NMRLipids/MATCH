#Original data from https://zenodo.org/record/2578069#.XKcoA0N7mHl



wget  https://zenodo.org/record/2578069/files/md_400_500_POPE_slipid.xtc
wget  https://zenodo.org/record/2578069/files/md_00.tpr
wget 

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  md_400_500_POPE_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

#Original data from https://zenodo.org/record/2578069#.XKcoA0N7mHl



wget  https://zenodo.org/record/2578069/files/md_400_500_POPE_slipid.xtc
wget  https://zenodo.org/record/2578069/files/md_00.tpr
wget 

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  md_400_500_POPE_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

#Original data from https://zenodo.org/record/2574689#.XKczT0N7nLB



wget  https://zenodo.org/record/2574689/files/m_400_500_POPC_slipid.xtc
wget  https://zenodo.org/record/2574689/files/md_04.tpr
wget 

mv  md_04.tpr topol.tpr
mv  conf.gro conf.gro

mv  md_400_500_POPC_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


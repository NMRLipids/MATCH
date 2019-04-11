#Original data from https://zenodo.org/record/2579224#.XK3MfEN7nLB



wget  https://zenodo.org/record/2579224/files/m_400_500_PG_PE_1_3_slipid.xtc
wget  https://zenodo.org/record/2579224/files/md_02.tpr
wget 

mv  md_02.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_PG_PE_1_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  m_400_500_PG_PE_1_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


#Original data from https://zenodo.org/record/2579108#.XKyz3kN7mHl



wget  https://zenodo.org/record/2579108/files/m_400_500_PG_PE_1_3_charmm.xtc
wget  https://zenodo.org/record/2579108/files/md_04.tpr
wget 

mv  md_04.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_PG_PE_1_3_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  m_400_500_PG_PE_1_3_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


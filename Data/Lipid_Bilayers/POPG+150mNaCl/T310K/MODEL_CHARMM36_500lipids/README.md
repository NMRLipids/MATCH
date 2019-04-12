#Original data from https://zenodo.org/record/2573531#.XKyvykN7mHl



wget  https://zenodo.org/record/2573531/files/m_400_500_POPG_charmm.xtc
wget  https://zenodo.org/record/2573531/files/topol.top
wget 

mv  topol.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_POPG_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat


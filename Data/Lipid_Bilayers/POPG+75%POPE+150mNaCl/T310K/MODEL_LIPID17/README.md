#Original data from https://zenodo.org/record/2579061#.XL7zL0N7nes



wget  https://zenodo.org/record/2579061/files/m_400_500_PG_PE_1_3_lipid.xtc
wget  https://zenodo.org/record/2579061/files/md_00.tpr
wget  https://zenodo.org/record/2579061/files/gromacs.top

mv  md_04.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_PG_PE_1_3_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  m_400_500_PG_PE_1_3_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


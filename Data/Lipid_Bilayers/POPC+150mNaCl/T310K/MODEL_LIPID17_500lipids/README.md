#Original data from https://zenodo.org/record/2574959#.XLgsNkN7mHk



wget  https://zenodo.org/record/2574959/files/m_400_500_POPC_amber.xtc
wget  https://zenodo.org/record/2574959/files/md_00.tpr
wget  https://zenodo.org/record/2574959/files/amber.prmtop

mv  md_00.tpr topol.tpr
mv  conf.gro

mv  m_400_500_POPC_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat


#Original data from https://zenodo.org/record/3257649#.XROi0CZ7nLA



wget  https://zenodo.org/record/3257649/files/m_400_500_system_POPG_GROMOS.xtc
wget 
wget  https://zenodo.org/record/3257649/files/files/topol.top

mv  md_010.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_system_POPG_GROMOS.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_GROMOS-CKP_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat


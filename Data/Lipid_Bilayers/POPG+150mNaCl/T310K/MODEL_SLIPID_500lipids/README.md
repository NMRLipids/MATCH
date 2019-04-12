#Original data from https://zenodo.org/record/2562853#.XKsmAkN7mHl



wget  https://zenodo.org/record/2562853/files/m_400_500_POPG_slipid.xtc
wget 
wget 

mv  md_04.tpr topol.tpr
mv  conf.gro conf.gro

mv  md_400_500_POPG_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat
concentration 108mM 
#Original data from https://zenodo.org/record/2633773#.XKxen0N7mHl



wget  https://zenodo.org/record/2633773/files/m_400_500_POPG_slipid.xtc
wget  https://zenodo.org/record/2633773/files/topol.tpr
wget  https://zenodo.org/record/2633773/files/conf.gro

mv  topol.tpr topol.tpr
mv  conf.gro conf.gro

mv  md_400_500_POPG_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat


#Original data from https://zenodo.org/record/3249960#.XRXWJCZ7nLA



wget  https://zenodo.org/record/3249960/files/total_4_500.xtc
wget  https://zenodo.org/record/3249960/files/md_0.tpr
wget  https://zenodo.org/record/3249960/files/conf.gro
wget 

mv  md_0.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  total_4_500.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


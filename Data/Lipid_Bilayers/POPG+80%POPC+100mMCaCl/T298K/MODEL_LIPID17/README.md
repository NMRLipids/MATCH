# Data in http://doi.org/10.5281/zenodo.3833725

wget https://zenodo.org/record/3833725/files/traj.xtc
wget https://zenodo.org/record/3833725/files/topol.tpr
wget https://zenodo.org/record/3833725/files/conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

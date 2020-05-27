# Data from http://doi.org/10.5281/zenodo.3857816

wget https://zenodo.org/record/3857816/files/run2.tpr
wget https://zenodo.org/record/3857816/files/run2.xtc
wget https://zenodo.org/record/3857816/files/run2.gro

mv run2.tpr topol.tpr
mv run2.xtc traj.xtc
mv run2.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

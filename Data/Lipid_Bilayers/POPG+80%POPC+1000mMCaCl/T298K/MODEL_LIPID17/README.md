# Data from  https://doi.org/10.5281/zenodo.3516709

wget https://zenodo.org/record/3516710/files/md.tpr
wget https://zenodo.org/record/3516710/files/run_150ns.xtc

mv md.tpr topol.tpr
mv run_150ns.xtc traj.xtc

mv structure.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

# Data from http://doi.org/10.5281/zenodo.3874378
# last 200ns from 1200ns simulation

#mv run3.tpr topol.tpr
#echo System | gmx trjconv -f run3.xtc -s topol.tpr -o traj.xtc -b 200000
#mv run3.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

# Data from https://doi.org/10.5281/zenodo.3571070

#wget https://zenodo.org/record/3571071/files/pope.xtc
#wget https://zenodo.org/record/3571071/files/pope.tpr
#wget https://zenodo.org/record/3571071/files/pope.gro

mv pope.gro conf.gro
mv pope.tpr topol.tpr
echo System | gmx trjconv -f pope.xtc -s topol.tpr -o traj.xtc -b 150000

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_MACROG_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat
~/work/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPE.dat  > Headgroup_Glycerol_Order_Parameters_Simulation.dat

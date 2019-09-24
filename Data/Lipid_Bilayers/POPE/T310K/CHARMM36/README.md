#Original data from https://doi.org/10.5281/zenodo.2641986 



wget  https://zenodo.org/record/2641987/files/POPE_C36_310K.xtc
wget  https://zenodo.org/record/2641987/files/POPE_C36_310K.tpr
wget  https://zenodo.org/record/2641987/files/POPE_C36_310K.gro

mv  POPE_C36_310K.tpr topol.tpr
mv  POPE_C36_310K.gro conf.gro

echo System | gmx trjconv -f POPE_C36_310K.xtc -s topol.tpr -b 100000 -o traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPE.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat


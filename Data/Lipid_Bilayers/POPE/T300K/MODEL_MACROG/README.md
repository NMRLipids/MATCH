# Data https://doi.org/10.5281/zenodo.3725669

 wget https://zenodo.org/record/3725670/files/md_OK_100.xtc
 wget https://zenodo.org/record/3725670/files/md.tpr
# wget https://zenodo.org/record/3725670/files/md.gro

mv md.gro conf.gro
mv md.tpr topol.tpr
echo System | gmx trjconv -f md_OK_100.xtc -s topol.tpr -o traj.xtc -b 200000

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_MACROG_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat
~/work/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPE.dat  > Headgroup_Glycerol_Order_Parameters_Simulation.dat

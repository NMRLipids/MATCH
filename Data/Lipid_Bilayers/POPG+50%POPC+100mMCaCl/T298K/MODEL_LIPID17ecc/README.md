# Data available from http://doi.org/10.5281/zenodo.3855729

mv run.tpr topol.tpr
echo System | gmx trjconv -f run.xtc -o traj.xtc -s topol.tpr -b 100000 
awk -f /home/samuli/work/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+50%POPC/T298K/MODEL_LIPID17ecc/FIXgro.awk run.gro > conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPCecc.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

# Data from http://doi.org/10.5281/zenodo.3862036

mv run2.tpr topol.tpr
mv run2.xtc traj.xtc 
awk -f /home/samuli/work/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+50%POPC/T298K/MODEL_LIPID17ecc/FIXgro.awk run2.gro > conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPCecc.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

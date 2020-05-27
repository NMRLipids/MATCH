# scp ohs@puhti.csc.fi:/scratch/project_2001058/Ollila/POPG+50%POPC/T298K/MODEL_LIPID17ecc2/*xtc ./

mv run3.tpr topol.tpr
mv run3.xtc traj.xtc
awk -f FIXgro.awk run2_11ns.gro > conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPCecc.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

#Original data from https://zenodo.org/record/2573905#.XLcD8EN7net



wget  https://zenodo.org/record/2573905/files/dm_400_500_POPG_amber.xtc
wget  https://zenodo.org/record/2573905/files/md_01.tpr
wget  https://zenodo.org/record/2573905/files/amber.top

mv  md_01.tpr topol.tpr
mv  conf.gro

mv  dm_400_500_POPG_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat


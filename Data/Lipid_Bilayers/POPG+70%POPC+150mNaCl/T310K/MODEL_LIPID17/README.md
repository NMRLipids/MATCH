#Original data from https://zenodo.org/record/2585523#.XL8a70N7nes



wget  https://zenodo.org/record/2585523/files/dm_popc_popg_7_3_lipid17.xtc
wget  https://zenodo.org/record/2585523/files/md_08.tpr
wget  https://zenodo.org/record/2585523/files/amber.prmtop

mv  md_08.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popc_popg_7_3_lipid17.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  dm_popc_popg_7_3_lipid17.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat


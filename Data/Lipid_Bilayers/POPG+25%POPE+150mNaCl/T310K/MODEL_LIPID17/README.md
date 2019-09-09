#Original data from https://zenodo.org/record/2579344#.XL8Qm0N7nes



wget  https://zenodo.org/record/2579344/files/dm_popg_pope_3_1_amber.xtc
wget  https://zenodo.org/record/2579344/files/md_010.tpr
wget  https://zenodo.org/record/2579344/files/amber.prmtop

mv  md_010.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popg_pope_3_1_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  dm_popg_pope_3_1_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


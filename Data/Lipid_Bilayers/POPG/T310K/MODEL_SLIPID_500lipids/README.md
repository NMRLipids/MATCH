#Original data from https://zenodo.org/record/3364460#.XVPE9fx7nes



wget  https://zenodo.org/record/3364460/files/total_4_500.xtc
wget  https://zenodo.org/record/3364460/files/md_1.tpr
wget  https://zenodo.org/record/3364460/files/conf.gro

mv  md_1.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat


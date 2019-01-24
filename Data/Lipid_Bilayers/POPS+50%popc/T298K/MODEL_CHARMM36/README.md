#Original data from https://doi.org/10.5281/zenodo.2542163



wget  https://zenodo.org/record/2542164/files/run.wrapped.xtc
wget  https://zenodo.org/record/2542164/files/step7_1.tpr
wget  https://zenodo.org/record/2542164/files/step7_1.part0002.gro

mv  step7_1.tpr topol.tpr
mv  step7_1.part0002.gro conf.gro

gmx trjconv -f run.wrapped.xtc  -o  traj.xtc -b 20000
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPS.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPS.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_popc.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParspopc.dat


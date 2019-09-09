#Original data from https://doi.org/10.5281/zenodo.1306799



wget  https://zenodo.org/record/1306800/files/md_dt100_OK_centered.xtc
wget  https://zenodo.org/record/1306800/files/md.tpr
wget  https://zenodo.org/record/1306800/files/step6.4_equilibration.gro

mv  md.tpr topol.tpr
mv  step6.4_equilibration.gro conf.gro

echo System | gmx trjconv -f md_dt100_OK_centered.xtc -o traj.xtc -b 50000
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh


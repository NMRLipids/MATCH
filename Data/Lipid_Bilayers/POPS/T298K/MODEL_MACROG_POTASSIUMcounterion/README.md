#Original data from https://doi.org/10.5281/zenodo.1434990



wget  https://zenodo.org/record/1434990/files/POPS_k.xtc
wget  https://zenodo.org/record/1434990/files/POPS_k.tpr
wget  https://zenodo.org/record/1434990/files/POPS_k.gro

mv  POPS_k.tpr topol.tpr
mv  POPS_k.gro conf.gro

echo System | gmx trjconv -f POPS_k.xtc -s topol.tpr -b 50000 -o traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_MACROG_POTASSIUMcounterion_POPS.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh

gmx density -f traj.xtc -s topol.tpr -dens number -o Kdens.xvg -center

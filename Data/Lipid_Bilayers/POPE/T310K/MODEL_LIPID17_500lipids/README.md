

#Original data from https://zenodo.org/record/3378970#.XWVSGvx7mHk

wget https://zenodo.org/record/4424292/files/md_400_500.xtc
wget https://zenodo.org/record/4424292/files/md.tpr
wget https://zenodo.org/record/3378970/files/conf.gro

mv md.tpr topol.tpr
echo System | gmx trjconv -f md_400_500.xtc -s topol.tpr -skip 5 -o traj.xtc

cp ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


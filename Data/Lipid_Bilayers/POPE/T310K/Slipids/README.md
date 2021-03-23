#Original data from https://doi.org/10.5281/zenodo.1293812



wget  https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1_100-200ns.xtc
wget  https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
wget  https://zenodo.org/record/1293813/files/for-md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.tpr
wget https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.gro

mv  for-md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.tpr topol.tpr
mv md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.gro conf.gro

rm traj_pbc.xtc
cp  md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1_100-200ns.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_Slipids_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep_1.dat

rm traj_pbc.xtc
cp  md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc  traj.xtc
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep_2.dat

paste OrdParsPOPE_rep_1.dat OrdParsPOPE_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk

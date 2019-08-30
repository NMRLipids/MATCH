#Data available from https://zenodo.org/record/1293774

wget https://zenodo.org/record/1293774/files/md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1_100-200ns.xtc
wget https://zenodo.org/record/1293774/files/for-md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1.tpr
wget https://zenodo.org/record/1293774/files/md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1.gro
wget https://zenodo.org/record/1293774/files/md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v2_100-200ns.xtc
#wget https://zenodo.org/record/1293774/files/for-md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v2.tpr

mv md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1_100-200ns.xtc traj.xtc
mv for-md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1.tpr topol.tpr
mv md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v1.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36ua_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep_1.dat

mv md_POPE_hexagonal_membrane_CHARMM36_UA_200ns_v2_100-200ns.xtc traj.xtc
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep_2.dat

paste OrdParsPOPE_rep_1.dat OrdParsPOPE_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk

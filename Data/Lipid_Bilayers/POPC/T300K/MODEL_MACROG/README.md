#Original data from http://doi.org/10.5281/zenodo.3741793 

wget https://zenodo.org/record/3741793/files/md_OK_100.xtc
wget https://zenodo.org/record/3741793/files/md.tpr
wget https://zenodo.org/record/3741793/files/md.gro
wget https://www.dsimb.inserm.fr/~fuchs/project_Samuli/POPC_POPE/automatic_POPCmacrog_fixed.def

mv  md.tpr topol.tpr
mv  md.gro conf.gro

echo System | gmx trjconv -f md_OK_100.xtc -o traj.xtc -b 200000

cp automatic_POPCmacrog_fixed.def defFILE.def
#cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh


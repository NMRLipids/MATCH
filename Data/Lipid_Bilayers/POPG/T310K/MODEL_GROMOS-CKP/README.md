#Original data from https://zenodo.org/record/3484548#.XRncliZ7nes



wget  https://zenodo.org/record/3484548/files/total_4_500.xtc
wget  https://zenodo.org/record/3484548/files/md_1.tpr
wget  https://zenodo.org/record/3484548/files/conf.gro

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_GROMOS-CKP_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

#Original data from https://zenodo.org/record/3484548#.XRuOJCZ7nes



wget  https://zenodo.org/record/3484548/files/total_4_500.xtc
wget  https://zenodo.org/record/3484548/files/md_00.tpr
wget  https://zenodo.org/record/3484548/files/conf.gro

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc

python2 ./opAAUA_03.py -p conf.gro  -i  POPG-head.itp -a ignH -u ''  -x traj.xtc  -o  POPG_head_total.txt

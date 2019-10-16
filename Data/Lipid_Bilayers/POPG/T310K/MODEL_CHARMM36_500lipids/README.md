#Original data from https://zenodo.org/record/3237463#.XRSCqSZ7nLA



wget  https://zenodo.org/record/3237463/files/total_4_500.xtc
wget  https://zenodo.org/record/3237463/files/md_0.tpr
wget  https://zenodo.org/record/3237463/files/conf.gro

mv  md_0.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

gmx density -f traj.xtc -s topol.tpr -dens number -o IONdens.xvg -center
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "apl  "$1*2/500}'

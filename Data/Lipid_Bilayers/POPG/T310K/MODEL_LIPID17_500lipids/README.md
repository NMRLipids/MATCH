# Data with correct dihedral https://doi.org/10.5281/zenodo.3832218


wget  https://zenodo.org/record/3832219/files/total_4_500_last.xtc
wget  https://zenodo.org/record/3832219/files/md.tpr
wget  https://zenodo.org/record/3832219/files/membrane500ns.gro

mv  md.tpr topol.tpr
awk -f  ~/Dropbox/codes/gro_repair.awk membrane500ns.gro > conf.gro

mv  total_4_500_last.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

gmx density -f traj.xtc -s topol.tpr -dens number -o IONdens.xvg -center
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "apl  "$1*2/500}'

#Original data from https://doi.org/10.5281/zenodo.2574533

wget https://zenodo.org/record/2578069/files/md_400_500_POPE_slipid.xtc
wget https://zenodo.org/record/2578069/files/md_00.tpr


mv md_00.tpr topol.tpr

mv md_400_500_POPE_slipid.xtc traj.xtc
gmx trjconv -f traj.xtc -s topol.tpr -dump 0 -o conf.gro
cp ../../../../../scripts/orderParm_defs/order_parameter_definitions_Slipids_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPE.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat

gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/500}'





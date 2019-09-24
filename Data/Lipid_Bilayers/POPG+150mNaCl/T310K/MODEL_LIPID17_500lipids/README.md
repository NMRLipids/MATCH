#Original data from https://zenodo.org/record/2573905#.XLcD8EN7net



wget  https://zenodo.org/record/2573905/files/dm_400_500_POPG_amber.xtc
wget  https://zenodo.org/record/2573905/files/md_01.tpr
wget  https://zenodo.org/record/2573905/files/amber.top

mv  md_01.tpr topol.tpr
mv  conf.gro

mv  dm_400_500_POPG_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat
sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPG.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat

gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/500}'

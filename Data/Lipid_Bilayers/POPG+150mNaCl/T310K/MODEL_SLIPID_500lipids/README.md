#Original data from https://zenodo.org/record/2633773#.XKxen0N7mHl

wget  https://zenodo.org/record/2633773/files/m_400_500_POPG_slipid.xtc
wget  https://zenodo.org/record/2633773/files/topol.tpr
wget  https://zenodo.org/record/2633773/files/conf.gro

mv  topol.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_POPG_slipid.xtc traj.xtc
#cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
#sh ../../../../../scripts/order_parameters_calculate.sh
#mv OrdPars.dat OrdParsPOPG.dat
#sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPG.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat

gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/500}'

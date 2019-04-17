#Original data from https://doi.org/10.5281/zenodo.2573530



wget  https://zenodo.org/record/2573531/files/m_400_500_POPG_charmm.xtc
wget  https://zenodo.org/record/2573531/files/topol.top
wget  https://zenodo.org/record/2573531/files/md_00.tpr

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_POPG_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat
sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPG.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat

gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/500}'

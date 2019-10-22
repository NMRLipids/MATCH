#Original data from https://zenodo.org/record/3378992


wget  https://zenodo.org/record/3378992/files/m_400_500_system_POPG_GROMOS.xtc
wget  https://zenodo.org/record/3378992/files/md_031.tpr
wget  https://zenodo.org/record/3378992/files/files/topol.top

mv  md_031.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_system_POPG_GROMOS.xtc traj.xtc
#cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_GROMOS-CKP_POPG.def defFILE.def
#sh ../../../../../scripts/order_parameters_calculate.sh
#mv OrdPars.dat OrdParsPOPG.dat



gmx density -f traj.xtc -s topol.tpr -dens number -o IONdens.xvg -center
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "apl  "$1*2/500}'

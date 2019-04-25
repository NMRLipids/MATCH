#Original data from https://zenodo.org/record/2577305#.XLiDK0N7mHk



wget  https://zenodo.org/record/2577305/files/m_400_500_POPE_amber.xtc
wget  https://zenodo.org/record/2577305/files/md_09.tpr
wget  https://zenodo.org/record/2577305/files/topol.top

mv  md_09.tpr topol.tpr
mv  conf.gro

mv  m_400_500_POPE_amber.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdParsPOPE.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat
gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2

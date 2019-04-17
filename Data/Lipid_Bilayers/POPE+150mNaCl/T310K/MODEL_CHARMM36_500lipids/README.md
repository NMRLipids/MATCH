#Original data from https://zenodo.org/record/2577454#.XKxrh0N7mHl



wget  https://zenodo.org/record/2577454/files/m_400_500_POPE_charmm.xtc
wget  https://zenodo.org/record/2577454/files/md_0100.tpr
wget  https://zenodo.org/record/2577454/files/conf.gro

mv  md_0100.tpr topol.tpr
mv  conf.gro conf.gro

mv  m_400_500_POPE_charmm.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdPars.dat > Headgroup_Glycerol_Order_Parameters_Simulation.dat
gmx density -f traj.xtc -s topol.tpr -dens number  -center -o IONdens.xvg -ng 2

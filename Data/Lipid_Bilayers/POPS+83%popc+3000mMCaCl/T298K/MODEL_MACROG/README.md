wget https://zenodo.org/record/1409551/files/PCPS_CACL2_3000.xtc
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_3000.tpr
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_3000.gro
mv PCPS_CACL2_3000.xtc traj.xtc 
mv PCPS_CACL2_3000.tpr topol.tpr
mv PCPS_CACL2_3000.gro conf.gro

gmx density -f traj.xtc -s topol.tpr -o IONdens.xvg -center -dens number -ng 3

sh order_parameters_calculatePOPC.sh
sh order_parameters_calculatePOPS.sh

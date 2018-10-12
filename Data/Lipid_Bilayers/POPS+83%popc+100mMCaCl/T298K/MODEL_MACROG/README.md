wget https://zenodo.org/record/1409551/files/PCPS_CACL2_100.xtc
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_100.tpr
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_100.gro
mv PCPS_CACL2_100.xtc traj.xtc 
mv PCPS_CACL2_100.tpr topol.tpr
mv PCPS_CACL2_100.gro conf.gro

gmx density -f traj.xtc -s topol.tpr -o IONdens.xvg -center -dens number -ng 3

sh order_parameters_calculatePOPC.sh
sh order_parameters_calculatePOPS.sh

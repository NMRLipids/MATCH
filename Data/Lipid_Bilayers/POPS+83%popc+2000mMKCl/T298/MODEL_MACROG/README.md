# Data from https://doi.org/10.5281/zenodo.1404040

wget https://zenodo.org/record/1404040/files/PCPS_KCL_2000.tpr
wget https://zenodo.org/record/1404040/files/PCPS_KCL_2000.xtc
mv PCPS_KCL_2000.tpr topol.tpr
mv PCPS_KCL_2000.xtc traj.xtc

gmx density -f traj.xtc -s topol.tpr -center -o Kdens.xvg

sh order_parameters_calculatePOPC.sh
sh order_parameters_calculatePOPS.sh

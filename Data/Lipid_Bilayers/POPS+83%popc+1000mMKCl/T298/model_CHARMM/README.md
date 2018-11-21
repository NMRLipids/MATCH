# Data available at https://doi.org/10.5281/zenodo.1493246

gmx trjconv -f run.trr -s topol.tpr -o traj.xtc -b 50000

sh order_parameters_calculatePOPC.sh
sh order_parameters_calculatePOPS.sh

gmx density -f traj.xtc -s topol.tpr -o IONdens.xvg -dens number -ng 2 -center

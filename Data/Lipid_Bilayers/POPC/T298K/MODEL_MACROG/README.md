# Data from http://doi.org/10.5281/zenodo.1167532

wget https://zenodo.org/record/1167532/files/popc298.xtc
wget https://zenodo.org/record/1167532/files/popc298.tpr

gmx trjconv -f popc298.xtc -s popc298.tpr -b 50000 -o traj.xtc
mv popc298.tpr topol.tpr

sh order_parameters_calculatePOPC.sh

# Data from https://doi.org/10.5281/zenodo.1210255

wget https://zenodo.org/record/1210256/files/PCPS-KCl1000.tpr
wget https://zenodo.org/record/1210256/files/PCPS-KCl1000.xtc
wget https://zenodo.org/record/1210256/files/PCPS-KCl1000.cpt

gmx trjconv -f PCPS-KCl1000.xtc -s PCPS-KCl1000.tpr -b 10000 -o traj.xtc
mv PCPS-KCl1000.tpr topol.tpr
mv PCPS-KCl1000.cpt run.cpt

# Data from https://doi.org/10.5281/zenodo.1210255

wget https://zenodo.org/record/1210256/files/PCPS-KCl4000.tpr
wget https://zenodo.org/record/1210256/files/PCPS-KCl4000.xtc
wget https://zenodo.org/record/1210256/files/PCPS-KCl4000.cpt

mv PCPS-KCl4000.tpr topol.tpr
mv PCPS-KCl4000.cpt run.cpt
gmx trjconv -f PCPS-KCl4000.xtc -s topol.tpr -b 75000 -o traj.xtc

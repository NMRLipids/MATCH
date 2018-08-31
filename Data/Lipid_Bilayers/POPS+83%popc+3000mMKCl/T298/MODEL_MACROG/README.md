# Data from https://doi.org/10.5281/zenodo.1210255

wget https://zenodo.org/record/1210256/files/PCPS-KCl3000.tpr
wget https://zenodo.org/record/1210256/files/PCPS-KCl3000.xtc
wget https://zenodo.org/record/1210256/files/PCPS-KCl3000.cpt

gmx trjconv -f PCPS-KCl3000.xtc -s PCPS-KCl3000.tpr -b 75000 -o traj.xtc
mv PCPS-KCl3000.tpr topol.tpr
mv PCPS-KCl3000.cpt run.cpt
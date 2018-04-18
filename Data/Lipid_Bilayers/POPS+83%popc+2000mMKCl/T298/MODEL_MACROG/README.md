# Data from https://doi.org/10.5281/zenodo.1210255

wget https://zenodo.org/record/1210256/files/PCPS-KCl2000.tpr
wget https://zenodo.org/record/1210256/files/PCPS-KCl2000.xtc
wget https://zenodo.org/record/1210256/files/PCPS-KCl2000.cpt

gmx trjconv -f PCPS-KCl2000.xtc -s PCPS-KCl2000.tpr -b 55000 -o traj.xtc
mv PCPS-KCl2000.tpr topol.tpr
mv PCPS-KCl2000.cpt run.cpt

# Data from https://doi.org/10.5281/zenodo.1210255

wget https://zenodo.org/record/1210256/files/PCPS-KCl500.tpr
wget https://zenodo.org/record/1210256/files/PCPS-KCl500.xtc
wget https://zenodo.org/record/1210256/files/PCPS-KCl500.cpt

gmx trjconv -f PCPS-KCl500.xtc -s PCPS-KCl500.tpr -b 10000 -o traj.xtc
mv PCPS-KCl500.tpr topol.tpr
mv PCPS-KCl500.cpt run.cpt
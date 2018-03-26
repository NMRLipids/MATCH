#From http://doi.org/10.5281/zenodo.1120287

wget https://zenodo.org/record/1120287/files/pops.tpr
wget https://zenodo.org/record/1120287/files/pops.xtc
wget https://zenodo.org/record/1120287/files/pops.ndx
wget https://zenodo.org/record/1120287/files/pops.cpt
mv pops.tpr topol.tpr
gmx trjconv -f pops.xtc -s topol.tpr -b 100000 -o traj.xtc
mv pops.ndx index.ndx
mv pops.cpt run.cpt

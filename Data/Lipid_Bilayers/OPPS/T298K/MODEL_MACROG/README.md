# THESE ARE ACTUALLY OPPS, NOT POPS, SEE: http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1513887245157#c9146940478822023431

#From http://doi.org/10.5281/zenodo.1120287

wget https://zenodo.org/record/1120287/files/pops.tpr
wget https://zenodo.org/record/1120287/files/pops.xtc
wget https://zenodo.org/record/1120287/files/pops.ndx
wget https://zenodo.org/record/1120287/files/pops.cpt
mv pops.tpr topol.tpr
gmx trjconv -f pops.xtc -s topol.tpr -b 100000 -o traj.xtc
mv pops.ndx index.ndx
mv pops.cpt run.cpt

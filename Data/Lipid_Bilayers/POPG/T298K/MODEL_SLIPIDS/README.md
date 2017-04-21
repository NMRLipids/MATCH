#From http://doi.org/10.5281/zenodo.546133
#

wget https://zenodo.org/record/546133/files/md50ns_chunk02.tpr
wget https://zenodo.org/record/546133/files/md50ns_chunk02.xtc
wget https://zenodo.org/record/546133/files/md50ns_chunk03.xtc
gmx trjcat -f md50ns_chunk02.xtc md50ns_chunk03.xtc -o trajectory
mv md50ns_chunk02.tpr topol.tpr

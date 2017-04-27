#From https://doi.org/10.5281/zenodo.546136

wget https://zenodo.org/record/546136/files/md50ns_chunk01.tpr
wget https://zenodo.org/record/546136/files/md50ns_chunk01.xtc
wget https://zenodo.org/record/546136/files/md50ns_chunk02.xtc
gmx trjcat -f md50ns_chunk01.xtc md50ns_chunk02.xtc -o trajectory
mv md50ns_chunk01.tpr topol.tpr

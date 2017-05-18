#From https://doi.org/10.5281/zenodo.495247

wget https://zenodo.org/record/495247/files/md50ns_chunk01.xtc
wget https://zenodo.org/record/495247/files/md50ns_chunk02.xtc
wget https://zenodo.org/record/495247/files/md50ns_chunk01.tpr
gmx trjcat -f md50ns_chunk01.xtc md50ns_chunk02.xtc -o trajectory
mv md50ns_chunk01.tpr topol.tpr

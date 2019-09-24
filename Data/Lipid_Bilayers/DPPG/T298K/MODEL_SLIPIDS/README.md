#From https://doi.org/10.5281/zenodo.546135

wget https://zenodo.org/record/546135/files/md50ns_chunk05.tpr
wget https://zenodo.org/record/546135/files/md50ns_chunk05.xtc
wget https://zenodo.org/record/546135/files/md50ns_chunk06.xtc
gmx trjcat -f md50ns_chunk05.xtc md50ns_chunk06.xtc -o trajectory
mv md50ns_chunk05.tpr topol.tpr
echo 0 | gmx trjconv -f trajectory.xtc -s topol.tpr -dump 200000 -o conf.gro

gmx density -f trajectory.xtc -s topol.tpr -dens number  -center -o IONdens.xvg
echo 0 | gmx traj -f trajectory.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/288}'

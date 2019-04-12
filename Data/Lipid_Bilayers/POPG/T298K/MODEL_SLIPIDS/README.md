#From http://doi.org/10.5281/zenodo.546133
#

wget https://zenodo.org/record/546133/files/md50ns_chunk02.tpr
wget https://zenodo.org/record/546133/files/md50ns_chunk02.xtc
wget https://zenodo.org/record/546133/files/md50ns_chunk03.xtc
gmx trjcat -f md50ns_chunk02.xtc md50ns_chunk03.xtc -o trajectory
mv md50ns_chunk02.tpr topol.tpr

gmx density -f trajectory.xtc -s topol.tpr -dens number  -center -o IONdens.xvg
echo 0 | gmx traj -f trajectory.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "SLIPIDS  "$1*2/288}'

#Original data from https://zenodo.org/record/3266166#.XRuOJCZ7nes



wget  https://zenodo.org/record/3266166/files/total_4_500.xtc
wget  https://zenodo.org/record/3266166/files/md_00.tpr
wget  https://zenodo.org/record/3266166/files/conf.gro

mv  md_00.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc

python2 ./opAAUA_03.py -p conf.gro  -i  POPG-head.itp -a ignH -u ''  -x traj.xtc  -o  POPG_head_total.txt

gmx density -f traj.xtc -s topol.tpr -dens number -o IONdens.xvg -center
echo 0 | gmx traj -f traj.xtc -s topol.tpr -ob box.xvg -xvg none
awk '{areaSUM=areaSUM+$2*$3; sum=sum+1}END{print areaSUM/sum}' box.xvg > area.dat
cat area.dat | awk '{print "apl  "$1*2/500}'

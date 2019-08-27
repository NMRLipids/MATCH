#Original data from https://zenodo.org/record/3237754#.XRncmiZ7nes



wget  https://zenodo.org/record/3237754/files/total_4_500.xtc
wget  https://zenodo.org/record/3237754/files/md_0.tpr
wget  https://zenodo.org/record/3237754/files/conf.gro

mv  md_0.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc

python2 ./opAAUA_03.py -p conf.gro  -i  POPE_GROMOS_head.itp -a ignH -u ''  -x total_4_500.xtc  -o  POPE_head_total.txt


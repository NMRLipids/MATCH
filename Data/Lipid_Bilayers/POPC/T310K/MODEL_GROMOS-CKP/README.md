#Original data from https://zenodo.org/record/3247435#.XRsaSSZ7net



wget  https://zenodo.org/record/3247435/files/total_4_500.xtc
wget  https://zenodo.org/record/3247435/files/md_0.tpr
wget  https://zenodo.org/record/3247435/files/conf.gro

mv  md_0.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc


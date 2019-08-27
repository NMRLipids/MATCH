#Original data from https://zenodo.org/record/3266238#.XRxwsCZ7nes



wget  https://zenodo.org/record/3266238/files/total_4_500.xtc
wget  https://zenodo.org/record/3266238/files/md_0.tpr
wget  https://zenodo.org/record/3266238/files/conf.gro

mv  md_0.tpr topol.tpr
mv  conf.gro conf.gro

mv  total_4_500.xtc traj.xtc

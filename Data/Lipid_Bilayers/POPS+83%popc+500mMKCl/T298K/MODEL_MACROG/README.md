# Data from https://doi.org/10.5281/zenodo.1404040

wget https://zenodo.org/record/1404040/files/PCPS-KCl500.tpr
wget https://zenodo.org/record/1404040/files/PCPS-KCl500.xtc
mv PCPS-KCl500.tpr topol.tpr
mv PCPS-KCl500.xtc traj.xtc

gmx density -f traj.xtc -s topol.tpr -center -o Kdens.xvg

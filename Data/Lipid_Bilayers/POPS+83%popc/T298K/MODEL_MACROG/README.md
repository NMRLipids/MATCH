wget https://zenodo.org/record/1409551/files/PCPS_CACL2_0.xtc
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_0.tpr
wget https://zenodo.org/record/1409551/files/PCPS_CACL2_0.gro
gmx trjconv -f PCPS_CACL2_0.xtc -o traj.xtc -b 150000
mv PCPS_CACL2_0.tpr topol.tpr
mv PCPS_CACL2_0.gro conf.gro

gmx density -f traj.xtc -s topol.tpr -o Kdens.xvg -center -dens number


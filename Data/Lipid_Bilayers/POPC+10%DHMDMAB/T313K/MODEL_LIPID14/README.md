echo 0 | gmx traj -f run.trr -s run.tpr -ob box.xvg
echo 0 | gmx trjconv -f run.trr -s run.tpr -o trajectory.xtc -b 20000
cp run.tpr topol.tpr

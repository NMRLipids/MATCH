# Data available at https://doi.org/10.5281/zenodo.1475284

cp ~/NMRlipids/MATCH/MAPPING/mappingPOPSberger.txt ./mappingFILE.txt

cp ~/NMRlipids/MATCH/scratch/report/gro_OP.awk ./

gmx trjconv -f run.trr -s run.tpr -o trajectory.xtc -b 40000

cp run.tpr topol.tpr

/home/samuli/Gromacs/gromacs402/bin/grompp -f run.mdp -c start.gro -p topol402.top -o topol402.tpr -v -n index.ndx -maxwarn 1

cp ../../../../../MAPPING/mappingPOPCberger.txt ./mappingFILEpopc.txt

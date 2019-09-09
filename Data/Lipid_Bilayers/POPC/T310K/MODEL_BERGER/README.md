# From publication Ollila et al. J. Phys. Chem. B 2007, 111, 3139-3150.
# Data is in https://doi.org/10.5281/zenodo.1230169 

cp ~/NMRlipids/MATCH/MAPPING/mappingPOPSberger.txt ./mappingFILE.txt
cp ~/NMRlipids/MATCH/scratch/report/gro_OP.awk ./
cp /home/samuli/work/NMRlipids/MATCH/Data/Lipid_Bilayers/POPC/T298K/MODEL_Berger/ffgmx2.hdb ./
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/traj10-50ns.trr ./run.trr
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/topol_10-11.tpr ./topol.tpr
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/pr1ns.mdp ./
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/confout_10-11.gro ./
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/popc.top ./
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/lipid.itp ./
cp /media/samuli/be85b54b-6796-4273-9ee1-0914d3a40746/nonionics/POPColdDATA/popc.itp ./

/home/samuli/gromacs/gromacs407/bin/grompp -f pr1ns.mdp -c confout_10-11.gro -p popc.top -o topol407.tpr -v # -n index.ndx -maxwarn 1
cp ../../../../../MAPPING/mappingPOPCberger.txt ./mappingFILEpopc.txt

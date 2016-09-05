# Data from http://dx.doi.org/10.5281/zenodo.15549

wget https://zenodo.org/record/15549/files/dppcRUN5-30ns.trr
wget https://zenodo.org/record/15549/files/dppcRUN2.tpr
cp ../../../../../MAPPING/mappingDPPCcharmm.txt ./mappingFILE.txt
~/gromacs/gromacs455/bin/trjconv -f dppcRUN5-30ns.trr -s dppcRUN2.tpr -o trajectory.xtc
mv dppcRUN2.tpr topol.tpr

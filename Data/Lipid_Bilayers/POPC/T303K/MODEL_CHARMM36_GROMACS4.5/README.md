Model from http://dx.doi.org/10.5281/zenodo.13944

wget https://zenodo.org/record/13944/files/popcRUN2-3.trr
wget https://zenodo.org/record/13944/files/popcRUN2.tpr

mv popcRUN2-3.trr trajectory.xtc
mv popcRUN2.tpr topol.tpr

cp /wrk/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
wget https://zenodo.org/record/13944/files/popcRUN3.gro
popcRUN3.gro conf.gro

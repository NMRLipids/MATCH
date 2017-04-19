#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.61992

wget https://zenodo.org/record/61992/files/chol50.tpr
wget https://zenodo.org/record/61992/files/chol50.xtc

mv chol50.xtc trajectory.xtc
mv chol50.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

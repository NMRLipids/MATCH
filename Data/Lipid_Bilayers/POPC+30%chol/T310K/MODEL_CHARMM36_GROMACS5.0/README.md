#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.61649

wget https://zenodo.org/record/61649/files/chol30.tpr
wget https://zenodo.org/record/61649/files/chol30.xtc

mv chol30.xtc trajectory.xtc
mv chol30.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

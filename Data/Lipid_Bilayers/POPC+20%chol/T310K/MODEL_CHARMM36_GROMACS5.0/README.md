#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.159759

wget https://zenodo.org/record/159759/files/chol20.tpr
wget https://zenodo.org/record/159759/files/chol20.xtc

mv chol20.xtc trajectory.xtc
mv chol20.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

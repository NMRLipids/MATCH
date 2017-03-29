#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.13877

wget https://zenodo.org/record/13877/files/md_chol10.xtc
wget https://zenodo.org/record/13877/files/md_chol10.tpr

mv md_chol10.xtc trajectory.xtc
mv md_chol10.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCmacrog.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLmacrog.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.60607

wget https://zenodo.org/record/60607/files/chol10.tpr
wget https://zenodo.org/record/60607/files/chol10.xtc

mv chol10.xtc trajectory.xtc
mv chol10.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLslipid.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  


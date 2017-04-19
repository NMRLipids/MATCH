#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.60607

wget https://zenodo.org/record/60607/files/chol20.tpr
wget https://zenodo.org/record/60607/files/chol20.xtc

mv chol20.xtc trajectory.xtc
mv chol20.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLslipid.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  


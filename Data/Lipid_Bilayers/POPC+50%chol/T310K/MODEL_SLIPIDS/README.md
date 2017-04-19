#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.154346

wget https://zenodo.org/record/154346/files/chol50.tpr
wget https://zenodo.org/record/154346/files/chol50.xtc

mv chol50.xtc trajectory.xtc
mv chol50.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLslipid.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  


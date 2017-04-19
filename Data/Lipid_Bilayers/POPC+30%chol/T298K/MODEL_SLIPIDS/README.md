#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.62026

wget https://zenodo.org/record/62026/files/popc30_T298_every100ps.tpr
wget https://zenodo.org/record/62026/files/popc30_T298_every100ps.xtc

mv popc30_T298_every100ps.tpr topol.tpr
mv popc30_T298_every100ps.xtc trajectory.xtc

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLslipid.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  


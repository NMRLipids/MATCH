#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.14068

wget https://zenodo.org/record/14068/files/POPC_50CHL.xtc
wget https://zenodo.org/record/14068/files/POPC_50CHL.tpr

mv POPC_50CHL.xtc trajectory.xtc
mv POPC_50CHL.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

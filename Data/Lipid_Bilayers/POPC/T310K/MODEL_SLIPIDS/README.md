#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.60607

wget https://zenodo.org/record/60607/files/chol0.tpr
wget https://zenodo.org/record/60607/files/chol0.xtc

mv chol0.xtc trajectory.xtc
mv chol0.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat



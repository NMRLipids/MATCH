#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.159759

wget https://zenodo.org/record/159759/files/chol0.xtc
wget https://zenodo.org/record/159759/files/chol0.tpr

mv chol0.xtc traj.xtc
mv chol0.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

cp ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPC.def ./defFILE.def

gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/order_parameters_calculate.sh

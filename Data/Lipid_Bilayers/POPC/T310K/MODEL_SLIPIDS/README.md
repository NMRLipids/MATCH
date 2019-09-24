#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.60607

wget https://zenodo.org/record/60607/files/chol0.tpr
wget https://zenodo.org/record/60607/files/chol0.xtc

mv chol0.xtc traj.xtc
mv chol0.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCslipids.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLslipid.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

cp ../../../../../scripts/orderParm_defs/order_parameter_definitions_slipids_POPC_all.def ./defFILE.def

gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/order_parameters_calculate.sh
sh ../../../../../scripts/calc_FORM_FACTOR.sh
python ../../../../../scripts/NMRL3_analysis/analysis_NMRL3.py


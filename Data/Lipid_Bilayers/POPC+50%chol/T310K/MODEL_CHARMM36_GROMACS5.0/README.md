#!/bin/bash
#Model from http://doi.org/10.5281/zenodo.61992

wget https://zenodo.org/record/61992/files/chol50.tpr
wget https://zenodo.org/record/61992/files/chol50.xtc

mv chol50.xtc traj.xtc
mv chol50.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

cp ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_CHARMM36_POPC.def ./defFILE.def

gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/order_parameters_calculate.sh
sh ../../../../../scripts/calc_FORM_FACTOR.sh
python ../../../../../scripts/NMRL3_analysis/analysis_NMRL3.py

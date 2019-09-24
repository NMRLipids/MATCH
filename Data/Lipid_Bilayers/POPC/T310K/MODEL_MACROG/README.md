#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.13877

wget https://zenodo.org/record/13877/files/md_chol0.xtc
wget https://zenodo.org/record/13877/files/md_chol0.tpr

mv md_chol0.xtc traj.xtc
mv md_chol0.tpr topol.tpr

cp ../../../../../../MATCH/MAPPING/mappingPOPCmacrog.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLmacrog.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

#../../../../../scripts/print_OP_defs_from_AWK.sh
# defFILE.def made partially by hand here due to overlapping atom names

echo System | gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/order_parameters_calculate.sh
sh ../../../../../scripts/calc_FORM_FACTOR.sh
python ../../../../../scripts/NMRL3_analysis/analysis_NMRL3.py


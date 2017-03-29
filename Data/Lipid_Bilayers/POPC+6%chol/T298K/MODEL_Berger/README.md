#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.13282

wget https://zenodo.org/record/13282/files/popcCHOL7molPER0-25ns.trr
wget https://zenodo.org/record/13282/files/popcCHOL7molPER25-50ns.trr
wget https://zenodo.org/record/13282/files/POPCchol5.tpr

gmx trjcat -f popcCHOL7molPER0-25ns.trr popcCHOL7molPER25-50ns.trr  -o trajectory.xtc
mv POPCchol5.tpr topol.tpr

rm popcCHOL7molPER0-25ns.trr popcCHOL7molPER25-50ns.trr


cp ../../../../../../NmrLipidsCholXray/MAPPING/mappingPOPCberger.txt ./mappingFILE.txt
cp ../../../../../../lipid_ionINTERACTION/scratch/ffgmx2berger.hdb ./ffgmx2.hdb
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat ./electronsLIPID.dat
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsHOLTJE.dat ./electronsCHOL.dat 


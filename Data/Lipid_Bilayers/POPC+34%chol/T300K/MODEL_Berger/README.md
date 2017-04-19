#!/bin/bash
#Model from {http://dx.doi.org/10.5281/zenodo.13283

wget https://zenodo.org/record/13283/files/popcCHOL34molPER0-25ns.trr
wget https://zenodo.org/record/13283/files/popcCHOL34molPER25-50ns.trr
wget https://zenodo.org/record/13283/files/POPCchol4.tpr

gmx trjcat -f popcCHOL34molPER0-25ns.trr popcCHOL34molPER25-50ns.trr -o trajectory.xtc
mv POPCchol4.tpr topol.tpr

rm popcCHOL34molPER0-25ns.trr popcCHOL34molPER25-50ns.trr


cp ../../../../../../NmrLipidsCholXray/MAPPING/mappingPOPCberger.txt ./mappingFILE.txt
cp ../../../../../../lipid_ionINTERACTION/scratch/ffgmx2berger.hdb ./ffgmx2.hdb
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat ./electronsLIPID.dat
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsHOLTJE.dat ./electronsCHOL.dat 


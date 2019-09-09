#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.13285

wget https://zenodo.org/record/13285/files/popcCHOL50molPER0-25ns.trr.gz
wget https://zenodo.org/record/13285/files/popcCHOL50molPER25-50ns.trr.gz
wget https://zenodo.org/record/13285/files/POPCchol5.tpr
wget https://zenodo.org/record/13285/files/CHOLpopc.mdp
wget https://zenodo.org/record/13285/files/CHOLpopc.top
wget https://zenodo.org/record/13285/files/cholesterol_new.itp
wget https://zenodo.org/record/13285/files/ff_dum.itp
wget https://zenodo.org/record/13285/files/ffgmx.itp
wget https://zenodo.org/record/13285/files/ffgmxbon.itp
wget https://zenodo.org/record/13285/files/ffgmxnb.itp
wget https://zenodo.org/record/13285/files/lipid.itp
wget https://zenodo.org/record/13285/files/endCONF.gro
wget https://zenodo.org/record/13279/files/popc.itp

gunzip popcCHOL50molPER0-25ns.trr.gz popcCHOL50molPER25-50ns.trr.gz
gmx trjcat -f popcCHOL50molPER0-25ns.trr popcCHOL50molPER25-50ns.trr -o traj.xtc
mv POPCchol5.tpr topol.tpr

rm popcCHOL50molPER0-25ns.trr popcCHOL50molPER25-50ns.trr

cp ../../../../../../MATCH/MAPPING/mappingPOPCberger.txt ./mappingFILE.txt
cp ../../../../../../lipid_ionINTERACTION/scratch/ffgmx2berger.hdb ./ffgmx2.hdb
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat ./electronsLIPID.dat
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsHOLTJE.dat ./electronsCHOL.dat 

echo System | gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/calc_FORM_FACTOR.sh
python ../../../../../scripts/NMRL3_analysis/analysis_NMRL3.py

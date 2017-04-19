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
gmx trjcat -f popcCHOL50molPER0-25ns.trr popcCHOL50molPER25-50ns.trr -o trajectory.xtc
mv POPCchol5.tpr topol.tpr

rm popcCHOL50molPER0-25ns.trr popcCHOL50molPER25-50ns.trr

cp /m/nbe/work/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/MAPPING/mappingPOPCberger.txt ./mappingFILE.txt
cp /m/nbe/work/ollilas1/HGmodel/NMRlipids/lipid_ionINTERACTION/scratch/ffgmx2berger.hdb ./ffgmx2.hdb
cp /m/nbe/work/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat ./electronsLIPID.dat
cp /m/nbe/work/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/scratch/POPCberger/electronsHOLTJE.dat ./electronsCHOL.dat 

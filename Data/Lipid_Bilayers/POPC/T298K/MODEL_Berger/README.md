Model from http://dx.doi.org/10.5281/zenodo.13279

#wget https://zenodo.org/record/13279/files/popc0-25ns.trr
#wget https://zenodo.org/record/13279/files/popc25-50ns.trr
#wget https://zenodo.org/record/13279/files/popc407.tpr
#wget https://zenodo.org/record/13279/files/endCONF.gro

gmx trjcat -f popc0-25ns.trr popc25-50ns.trr -o traj.xtc
mv popc407.tpr topol.tpr


cp ../../../../../MAPPING/mappingPOPCberger.txt mappingFILE.txt
cp /wrk/ollilas1/HGmodel/NMRlipids/lipid_ionINTERACTION/scratch/ffgmx2berger.hdb ./ffgmx2.hdb
cp ../../../../../../NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat ./electronsLIPID.dat

echo System | gmx trjconv -f traj.xtc -s topol.tpr -o conf.gro -dump 0

sh ../../../../../scripts/calc_FORM_FACTOR.sh
python ../../../../../scripts/NMRL3_analysis/analysis_NMRL3.py

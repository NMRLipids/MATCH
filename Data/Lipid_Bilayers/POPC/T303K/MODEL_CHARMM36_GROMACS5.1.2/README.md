#Order parameters
#Delivered by Tom Piggot at https://github.com/NMRLipids/NmrLipidsCholXray/issues/4#issuecomment-247146648 
#and https://github.com/NMRLipids/NmrLipidsCholXray/issues/4#issuecomment-250514441
#
#Trajectories from http://doi.org/10.5281/zenodo.153944

wget https://zenodo.org/record/153944/files/step7_11.tpr
wget https://zenodo.org/record/153944/files/step7_11_100-150ns.xtc
wget https://zenodo.org/record/153944/files/step7_11_150-200ns.xtc
gmx trjcat -f step7_11_100-150ns.xtc step7_11_150-200ns.xtc -o trajectory.xtc
mv step7_11.tpr topol.tpr
cp ../../../../../../MATCH/MAPPING/mappingPOPCcharmm.txt ./mappingFILE.txt
awk -f ../../../../../scripts/makeELECTRONSpopc.awk mappingFILE.txt > electronsLIPID.dat

cp ../../../../../../MATCH/MAPPING/mappingCHOLESTEROLcharmm.txt ./mappingFILEchol.txt
awk -f ../../../../../scripts/makeELECTRONSchol.awk mappingFILEchol.txt > electronsCHOL.dat  

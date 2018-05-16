# Data from https://doi.org/10.5281/zenodo.1227256 
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1524581650542#c4627966291656120911

wget https://zenodo.org/record/1227257/files/PCPS-KCl500_rep1.nc
wget https://zenodo.org/record/1227257/files/PCPS-KCl500mm.prmtop

mv PCPS-KCl500_rep1.nc ncFILE.nc
mv PCPS-KCl500mm.prmtop prmtopFILE.prmtop

python2 ~/work/NMRLipids/MATCH/scratch/scriptsBYmelcr/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE.nc  -o OrdParsDOPS.dat
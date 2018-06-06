# Data from http://doi.org/10.5281/zenodo.1227272
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1524581650542#c4627966291656120911

wget https://zenodo.org/record/1227272/files/PCPS-KCl500_rep1.nc
wget https://zenodo.org/record/1227272/files/PCPS-NaCl500mm.prmtop

mv PCPS-KCl500_rep1.nc ncFILE.nc
mv PCPS-NaCl500mm.prmtop prmtopFILE.prmtop

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE.nc  -o OrdParsPOPS.dat
python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_POPC.dat -t prmtopFILE.prmtop -x ncFILE.nc  -o OrdParsPOPC.dat

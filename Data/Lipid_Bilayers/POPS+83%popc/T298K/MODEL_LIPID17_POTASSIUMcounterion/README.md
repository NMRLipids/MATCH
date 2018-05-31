# Data from http://doi.org/10.5281/zenodo.1250969
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1526998237114#c8209972530968067707

wget https://zenodo.org/record/1250969/files/PSPC_KCl_rep_1.nc 
wget https://zenodo.org/record/1250969/files/PSPC_KCl_rep_2.nc 
wget https://zenodo.org/record/1250969/files/membrane_64_64_water.prmtop

mv PCPS_KCl_rep1.nc ncFILE1.nc
mv PCPS_KCl_rep2.nc ncFILE2.nc
mv membrane_64_64_water.prmtop prmtopFILE.prmtop

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE1.nc  -o OrdParsPOPS_rep_1.dat
python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE2.nc  -o OrdParsPOPS_rep_2.dat
python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_POPC.dat -t prmtopFILE.prmtop -x ncFILE1.nc  -o OrdParsPOPC_rep_1.dat
python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_POPC.dat -t prmtopFILE.prmtop -x ncFILE2.nc  -o OrdParsPOPC_rep_2.dat

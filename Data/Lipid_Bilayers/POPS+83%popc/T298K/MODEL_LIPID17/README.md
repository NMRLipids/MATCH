# Data from http://doi.org/10.5281/zenodo.1250975
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1526998237114#c8209972530968067707

wget https://zenodo.org/record/1250975/files/PSPC_NaCl_rep_1.nc
wget https://zenodo.org/record/1250975/files/PSPC_NaCl_rep_2.nc
wget https://zenodo.org/record/1250975/files/membrane_64_64_water.prmtop

mv PCPS-NaCl_rep1.nc ncFILE1.nc
mv PCPS-NaCl_rep2.nc ncFILE2.nc
mv PCPS-KCl1000mm.prmtop prmtopFILE.prmtop

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE.nc  -o OrdParsPOPS.dat
# Data from http://doi.org/10.5281/zenodo.1250975
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1526998237114#c8209972530968067707

wget https://zenodo.org/record/1250975/files/PSPC_NaCl_rep_1.nc

wget https://zenodo.org/record/1250975/files/PSPC_NaCl_rep_2.nc

wget https://zenodo.org/record/1250975/files/membrane_64_64_water.prmtop

mv PSPC_NaCl_rep_1.nc ncFILE1.nc

mv PSPC_NaCl_rep_2.nc ncFILE2.nc

mv membrane_64_64_water.prmtop prmtopFILE.prmtop

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE1.nc  -o OrdParsPOPS_rep_1.dat

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE2.nc  -o OrdParsPOPS_rep_2.dat

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_POPC.dat -t prmtopFILE.prmtop -x ncFILE1.nc  -o OrdParsPOPC_rep_1.dat

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_POPC.dat -t prmtopFILE.prmtop -x ncFILE2.nc  -o OrdParsPOPC_rep_2.dat

paste OrdParsPOPS_rep_1.dat OrdParsPOPS_rep_2.dat | awk '{if(NR==1){print "#Average over two replicas \n           #order parameter   sem"};if(NR>2){print $1"     "($5+$12)/2"          "($7+$14)/2}}' > OrdParsPOPS.dat

paste OrdParsPOPC_rep_1.dat OrdParsPOPC_rep_2.dat | awk '{if(NR==1){print "#Average over two replicas \n           #order parameter   sem"};if(NR>2){print $1"     "($5+$12)/2"          "($7+$14)/2}}' > OrdParsPOPC.dat

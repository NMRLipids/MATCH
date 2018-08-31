# Data from https://doi.org/10.5281/zenodo.1227256 
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1524581650542#c4627966291656120911

wget https://zenodo.org/record/1227257/files/PCPS-KCl4000_rep1.nc
wget https://zenodo.org/record/1227257/files/PCPS-KCl4000mm.prmtop

mv PCPS-KCl4000_rep1.nc ncFILE.nc
mv PCPS-KCl4000mm.prmtop prmtopFILE.prmtop

python2.7 ../../../../../scripts/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t prmtopFILE.prmtop -x ncFILE.nc  -o OrdParsPOPS.dat

paste OrdParPOPS_rep_1.dat OrdParPOPS_rep_2.dat | awk '{if(NR==1){print "#Average over two replicas \n           #order parameter   sem"};if(NR>2){print $1"     "($5+$12)/2"          "($7+$14)/2}}' > OrdParsPOPS.dat
paste OrdParPOPC_rep_1.dat OrdParPOPC_rep_2.dat | awk '{if(NR==1){print "#Average over two replicas \n           #order parameter   sem"};if(NR>2){print $1"     "($5+$12)/2"          "($7+$14)/2}}' > OrdParsPOPC.dat

# Data from http://doi.org/10.5281/zenodo.1135142
# by Batuhan Kav http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1515078990369#c1155009336153859041

wget https://zenodo.org/record/1135142/files/DOPS_amber_lipid17_ff99ions_prod_rep1.nc
wget https://zenodo.org/record/1135142/files/DOPS_amber_lipid17_ff99ions_prod_rep1.restart
wget https://zenodo.org/record/1135142/files/DOPS_amber_lipid17_ff99ions.prmtop

python2 ~/work/NMRLipids/MATCH/scratch/scriptsBYmelcr/calcOrderParameters.py -i order_parameter_definitions_Lipid14_DOPS.def -t DOPS_amber_lipid17_ff99ions.prmtop -x DOPS_amber_lipid17_ff99ions_prod_rep1.nc  -o OrdParsDOPS.dat
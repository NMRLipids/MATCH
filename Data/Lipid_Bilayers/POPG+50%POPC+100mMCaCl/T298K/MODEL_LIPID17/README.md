# THIS ZENODO REPOSITORY HAS STILL DATA RAN WITH INCORRECT DIHEDRAL PARAMETERS,
# SEE https://github.com/NMRLipids/NMRlipidsIVPEandPG/issues/12
# THE ANALYSIS IS DONE FROM CORRECTED TRAJECTORY, ZENODO REPOSITORY SHOULD BE UPDATED
# 
# Data from https://doi.org/10.5281/zenodo.3520498
#
#wget https://zenodo.org/record/3520499/files/md.tpr
#wget https://zenodo.org/record/3520499/files/run_150ns.xtc
#
#mv md.tpr topol.tpr
#mv run_150ns.xtc traj.xtc
#

# FROM ohs@puhti.csc.fi:/scratch/project_2001058/Ollila/POPG+50%POPC+100mMCaCl/T298K/MODEL_LIPID17/correctedDIHEDRAL
# last 198ns from 720ns simulation

#mv run3.tpr topol.tpr
#echo System | gmx trjconv -f run3.xtc -s topol.tpr -o traj.xtc -b 200000 -e 398000
#mv run2.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

# THIS ZENODO REPOSITORY HAS STILL DATA RAN WITH INCORRECT DIHEDRAL PARAMETERS,
# SEE https://github.com/NMRLipids/NMRlipidsIVPEandPG/issues/12
# THE ANALYSIS IS DONE FROM CORRECTED TRAJECTORY, ZENODO REPOSITORY SHOULD BE UPDATED
# 
# Data from https://doi.org/10.5281/zenodo.3520478
#

# wget https://zenodo.org/record/3520479/files/md.tpr
# wget https://zenodo.org/record/3520479/files/run_150ns.xtc

# mv md.tpr topol.tpr
# mv run_150ns.xtc traj.xtc
# mv structure.gro conf.gro

# FROM ohs@puhti.csc.fi:/scratch/project_2001058/Ollila/POPG+50%POPC/T298K/MODEL_LIPID17/correctedDIHEDRAL/
# last 200ns from 320ns simulation
mv run2.tpr topol.tpr
mv run2.xtc traj.xtc
mv run2.gro conf.gro

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPC.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPC.dat

cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_LIPID17_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

#!/bin/bash

# bash wrapper for calculating Order Parameters of lipid bilayer
# meant for use with NMRlipids projects

scriptdir="../../../../../scripts/"

traj_file_name="trajectory.xtc" 
traj_pbc_nonwat_file_name="traj_nonwat_pbc.xtc" #"../traj.trr" 
top_file_name="last_frame_nonwat.gro"
tpr_file_name="run.tpr"
#op_def_file="../../Headgroup_Glycerol_OPs.def"
op_def_file="/home/samuli/NMRlipids/NMRlipids_VI-NewIonModel/scripts/order_parameter_definitions_Lipid14_POPC_headgr.def"
op_out_file="OrdPars.dat"
top="topol.top"
f_conc=55430  # in mM/L

if ! [ -s $tpr_file_name ] 
then
    echo "We really need " $tpr_file_name " , but we can't find it!"
    exit 1
fi

# remove PBC:
! [ -s $traj_pbc_nonwat_file_name ] && echo non-water | gmx trjconv -f $traj_file_name -s $tpr_file_name -o $traj_pbc_nonwat_file_name -pbc mol

# get a non-water gro-file (topology)
if ! [ -s $top_file_name ] 
then
    echo non-water | gmx trjconv -f $traj_file_name -s $tpr_file_name -o $top_file_name -pbc mol -dump 20000
fi

#CALCULATE ORDER PARAMETERS
python $scriptdir/calcOrderParameters.py -i $op_def_file -t $top_file_name -x $traj_pbc_nonwat_file_name -o $op_out_file && rm $traj_pbc_nonwat_file_name


#getting concentration from topol.top file (if exists)
if [ -f $top ]
then
    nwat=`grep -e "molecules" -A 10 $top | grep -e "^SOL" -e "^TIP" -e "^OPC3" | cut -d " " -f1 --complement `
    nion=`grep -e "molecules" -A 10 $top | grep -e "^NA"  -e "^CA"  | cut -d " " -f1 --complement `
    [ -z $nion ] && nion=0

    conc=`echo $f_conc "*" $nion / $nwat  | bc`
    echo conc: $conc
    sed "s/conc/$conc/" -i ${op_out_file}.line
else
    echo "Topology probably not present, can't calculate concentration."
fi

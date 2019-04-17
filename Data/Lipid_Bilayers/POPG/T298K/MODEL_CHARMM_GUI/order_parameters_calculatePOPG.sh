#!/bin/bash

# bash wrapper for calculating Order Parameters of lipid bilayer
# meant for use with NMRlipids projects

scriptdir='/home/samuli/work/NMRlipids/MATCH/scratch/scriptsBYmelcr'

traj_file_name="run2.xtc" #"../traj.trr" 
traj_pbc_nonwat_file_name="run2_nonwat_pbc.xtc" #"../traj.trr" 
top_file_name="last_frame_nonwat.gro"
tpr_file_name="run2.tpr"
#op_def_file="../../Headgroup_Glycerol_OPs.def"
op_def_file="Headgroup_Glycerol_Order_Parameters_SimulationPOPG.def"
op_out_file="OrdParsPOPG.dat"
top="topol.top"
lipid="POPG"
f_conc=55430  # in mM/L

if ! [ -s $tpr_file_name ] 
then
    echo "We really need " $tpr_file_name " , but we can't find it!"
    exit 1
fi

# remove PBC:
! [ -s $traj_pbc_nonwat_file_name ] && echo $lipid | gmx trjconv -f $traj_file_name -s $tpr_file_name -o $traj_pbc_nonwat_file_name -pbc mol -b 20000

# get a non-water gro-file (topology)
if ! [ -s $top_file_name ] 
then
    if [ -s run2.cpt ]
    then
        echo $lipid | gmx trjconv -f run2.cpt -s $tpr_file_name -o $top_file_name -pbc mol
    else
        echo "Couldn't find state.cpt"
        exit 1
    fi
fi

#CALCULATE ORDER PARAMETERS
python $scriptdir/calcOrderParameters.py -i $op_def_file -t $top_file_name -x $traj_pbc_nonwat_file_name -o $op_out_file && rm $traj_pbc_nonwat_file_name


#getting concentration from topol.top file (if exists)
if [ -f $top ]
then
    nwat=`grep -e "molecules" -A 10 $top | grep -e "^SOL" -e "^TIP" | cut -d " " -f1 --complement `
    nion=`grep -e "molecules" -A 10 $top | grep -e "^NA"  -e "^CA"  | cut -d " " -f1 --complement `
    [ -z $nion ] && nion=0

    conc=`echo $f_conc "*" $nion / $nwat  | bc`
    echo conc: $conc
    sed "s/conc/$conc/" -i ${op_out_file}.line
else
    echo "Topology probably not present, can't calculate concentration."
fi

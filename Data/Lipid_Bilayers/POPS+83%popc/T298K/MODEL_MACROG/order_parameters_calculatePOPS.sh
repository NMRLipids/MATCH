#!/bin/bash

# Gromacs 5.x version of ...
# bash wrapper for calculating Order Parameters of lipid bilayer 
# python script/library calcOrderParameters.py
# meant for use with NMRlipids projects
#------------------------------------------------------------
# Made by J.Melcr,  Last edit 2017/03/21
#------------------------------------------------------------
#
# Generation of non-water trajectory removed by O.H.S Ollila, 2018/08/23
#

scriptdir='../../../../../scripts/'

traj_file_name="traj.xtc" #"run.trr" 
tpr_file_name="topol.tpr"
conf_file_name="conf.gro"
op_def_file="Headgroup_Glycerol_Order_Parameters_SimulationPOPS.def"
op_out_file="OrdParsPOPS.dat"
top="topol.top"
traj_pbc_file_name="traj_pbc.xtc"
f_conc=55430  # in mM/L

if ! [ -s $tpr_file_name ] 
then
    echo "We really need " $tpr_file_name " , but we can't find it!"
    exit 1
fi

# remove PBC:
! [ -s $traj_pbc_file_name ] && echo System | gmx trjconv -f $traj_file_name -s $tpr_file_name -o $traj_pbc_file_name -pbc mol

#CALCULATE ORDER PARAMETERS
python $scriptdir/calcOrderParameters.py -i $op_def_file -t $conf_file_name -x $traj_pbc_file_name -o $op_out_file


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

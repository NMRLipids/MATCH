#!/bin/bash
# Script that makes the molecules whole, centers the bilayer in box and outputs the form factor
# Authors: M. Miettinen, S. Ollila, H. Antila
#
# Usage example: ./center_n_calcFF mappingPOPCcharmm.txt popcRUN2.tpr popcRUN2.xtc centered.xtc
#


# Files needed: Mapping file, .tpr, trajectory, and electrons.dat where the number of electrons in each atomtype present is specified.
# Dependencies: gromacs
# Outputted files: centered trajectory, solvent electron density, lipid electron density, total electron density, centered total electron density, list of centes-of-mass
# Form factor outputted in STDOUT

echo
# Check the inputs:
if [ $4 ]
then
  mappingFile=$1 # File containing the names of atoms in this FF.
  tprFile=$2     # The input tpr-file.
  xtcFile=$3     # The input xtc-file.
  outFile=$4     # Name for the output xtc file.  
  echo "Mapping: ${mappingFile}"
  echo "TPR in:  ${tprFile}"
  echo "XTC in:  ${xtcFile}"
  echo "XTC out: ${outFile}"
else
  echo "Too few inputs, exiting."
  exit
fi

echo
echo "Will now CENTER trajectory ${xtcFile} to ${outFile}."
echo
### --- 1/3: Make all molecules whole --- ###
echo "Making molecules whole..."
echo "System" \
    | gmx trjconv -pbc whole \
	  -f $xtcFile \
	  -s $tprFile \
	  -o foo.xtc >& center.output
if [ `grep -c gcq center.output` == 1 ]
then
  grep Selected center.output
  grep frame center.output
else
  echo "    gmx trjconv failed, exiting."
  exit
fi
#
echo
#
### --- 2/3: Center around one lipid tail CH3 to guarantee all lipids in the same box --- ###
#
# Find the name in this FF: 
G1CH3name=`grep M_G1C[0-9]*_M $mappingFile | tail -n1 | awk '{print $2}'`
echo 'The name of the CH3 carbon in sn-1 chain:' $G1CH3name
#
# Find the number of the CH3 atom in the last lipid:
echo -e "a ${G1CH3name}\nq" | gmx make_ndx -f $tprFile -o foo.ndx >& make_ndx.output
G1CH3number=`tail -n1 foo.ndx | awk '{print $NF}'`
echo "The atom number of the last lipid's CH3: " $G1CH3number
rm make_ndx.output
#
# Add it in the index file:
echo '[ centralAtom ]' >> foo.ndx
echo $G1CH3number >> foo.ndx
#
# Center everything around it:
echo "Centering molecules around atom ${G1CH3number}..."
echo -e "centralAtom\nSystem" \
    | gmx trjconv -center -pbc mol \
	  -n foo.ndx \
	  -f foo.xtc \
	  -s $tprFile \
	  -o foo2.xtc >& center.output
if [ `grep -c gcq center.output` == 1 ]
then
  grep Selected center.output
else
  echo "    gmx trjconv failed, exiting."
  exit
fi
#
echo
#
### --- 3/3: Center around the center of mass of all the g_3 carbons --- ###
#
# Find the g3 carbons:
# ... find their name in this FF:
G1g3name=`grep M_G3_M $mappingFile | awk '{print $2}'`
echo 'The name of the g3 carbon:' $G1g3name
# ... and put them all to an index file:
rm foo.ndx
echo -e "a ${G1g3name}\nq" | gmx make_ndx -f $tprFile -o foo.ndx >& make_ndx.output
rm make_ndx.output
# Center around CoM of g3 carbons, that is, center of bilayer, and make molecules whole:
echo "Centering around the center of mass of ${G1g3name} atoms..."
echo -e "${G1g3name}\nSystem" \
    | gmx trjconv -center -pbc mol \
	  -n foo.ndx \
	  -f foo2.xtc \
	  -s $tprFile \
	  -o $outFile >& center.output
if [ `grep -c gcq center.output` == 1 ]
then
  grep Selected center.output
else
  echo "    gmx trjconv failed, exiting."
  exit
fi
rm center.output foo.xtc foo2.xtc
echo "Centering done"

#calculating the electron densities. Modified from Samuli's script by Hanne


SOLname=$(grep M_SOL_M ${mappingFile} | awk '{printf "%5s\n",$2}')
echo -e "${G1g3name}\n${SOLname}" | gmx density -center -n foo.ndx -f ${outFile} -s ${tprFile} -ei electrons.dat -dens electron -o electronDENSITYsol.xvg -xvg none -sl 100
LIPIDname=$(grep M_POPC_M  ${mappingFile} | awk '{printf "%5s\n",$2}')
echo -e "${G1g3name}\n${LIPIDname}" | gmx density -center -n foo.ndx -f ${outFile} -s ${tprFile} -ei electrons.dat -dens electron -o electronDENSITYlipid.xvg -xvg none -sl 100


if [ -e "electronDENSITYchol.xvg" ];
then
    paste electronDENSITYsol.xvg electronDENSITYlipid.xvg electronDENSITYchol.xvg | awk '{print $1" "$2+$4+$6}' > electronDENSITY.xvg
else
    paste electronDENSITYsol.xvg electronDENSITYlipid.xvg | awk '{print $1" "$2+$4+$6}' > electronDENSITY.xvg
fi

slice=$(head -n2 electronDENSITY.xvg | awk '{dz=$1-prev;prev=$1}END{print dz}')
bulkDENS=$(tail -n 1 electronDENSITY.xvg | awk '{print $2}')
cat electronDENSITY.xvg | awk -v slice=$slice -v bulkDENS=$bulkDENS 'BEGIN{scale=0.01;}{for(q=0;q<2000;q=q+1){F[q]=F[q]+($2-bulkDENS)*cos(scale*q*$1)*slice;}}END{for(q=0;q<1000;q=q+1){print 0.1*q*scale" "0.01*sqrt(F[q]*F[q])
}}' 
cp electronDENSITY.xvg Electron_Density_From_Simulation.dat

rm foo.ndx

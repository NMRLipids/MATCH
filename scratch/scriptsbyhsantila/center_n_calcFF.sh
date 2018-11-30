#!/bin/bash
# Script that makes the molecules whole, centers the bilayer in box and outputs the form factor.
#
# Authors: M. Miettinen, S. Ollila, H. Antila
#
# Usage example: ./center_n_calcFF mappingMolecules.txt mappingAtoms.txt popcRUN2.tpr popcRUN2.xtc centered.xtc
#
# Files needed:    Mapping files for [1] whole molecules (contains also the name of the corresponding
#                  electron file) and [2] atoms; [3] .tpr file; [4] trajectory; and [5] files where
#                  the number of electrons in each atomtype present is specified.
# Dependencies:    gromacs v 5 or later
# Assumptions:     Bilayer is symmetric
# Outputted files: centered trajectory, molecule-wise electron density profiles, total electron density profile
#
# Form factor outputted in STDOUT

echo
# Check the inputs:
if [ $5 ]
then
  molMappFile=$1 # File containing the names of molecules in this FF, and the names of the corresponding electron files.
  mappingFile=$2 # File containing the names of atoms in this FF.
  tprFile=$3     # The input tpr-file.
  xtcFile=$4     # The input xtc-file.
  outFile=$5     # Name for the output xtc file.
  echo "Mapping: ${molMappFile}"
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
intoGMXmake_ndx=`echo ${G1g3name} | sed 's/ / \| a /g'`
echo -e "a ${intoGMXmake_ndx}\nq" | gmx make_ndx -f $tprFile -o foo.ndx >& make_ndx.output
rm make_ndx.output
# ... and find the name given to their group in the index file:
G1g3name=`grep '\[' foo.ndx | tail -n1 | awk '{print $2}'`

# Center around CoM of g3 carbons, that is, center of bilayer, and make molecules whole:
echo "Centering around the center of mass of index group ${G1g3name}..."
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

#calculating the electron densities. Modified from Samuli's script by Hanne and Markus

echo
echo "Calculating density profiles..."
rm electronDENSITY.xvg; touch electronDENSITY.xvg
for mol in $(awk '{print $1}' ${molMappFile}); do
    molName=$(grep ${mol} ${molMappFile} | awk '{printf "%s\n",$2}')
    echo "- ${molName} -"
    eleFile=$(grep ${mol} ${molMappFile} | awk '{printf "%s\n", $3}')
    echo -e "${G1g3name}\n${molName}" | \
      gmx density -center -n foo.ndx -f ${outFile} -s ${tprFile} -ei ${eleFile} -dens electron -o electronDENSITY_$molName.xvg -xvg none -sl 100 >& density.output
    if [ `grep -c gcq density.output` == 1 ]
    then
      echo "The groups selected for centering and for density calculation:"
      grep Selected density.output
      rm density.output
      paste electronDENSITY.xvg electronDENSITY_$molName.xvg | awk '{print $1,$2+$4}' > foo.xvg
      mv foo.xvg electronDENSITY.xvg
    else
      echo "gmx density failed, exiting."
    exit
    fi
done

slice=$(head -n2 electronDENSITY.xvg | awk '{dz=$1-prev;prev=$1}END{print dz}')
bulkDENS=$(tail -n 1 electronDENSITY.xvg | awk '{print $2}')
cat electronDENSITY.xvg | awk -v slice=$slice -v bulkDENS=$bulkDENS 'BEGIN{scale=0.01;}{for(q=0;q<2000;q=q+1){F[q]=F[q]+($2-bulkDENS)*cos(scale*q*$1)*slice;}}END{for(q=0;q<1000;q=q+1){print 0.1*q*scale" "0.01*sqrt(F[q]*F[q])
}}' 
cp electronDENSITY.xvg Electron_Density_From_Simulation.dat

rm foo.ndx

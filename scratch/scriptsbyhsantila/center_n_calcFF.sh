#!/bin/bash
# Script that makes the molecules whole, centers the bilayer in box and outputs the form factor.
#
# Authors: M. Miettinen, S. Ollila, H. Antila
#
# Usage example: ./center_n_calcFF mappingMolecules.txt popcRUN2.tpr popcRUN2.xtc centered.xtc
#
# Files needed:    [1] Mapping file for whole molecules(*), [2] the .tpr file, [3] the trajectory file.
# Dependencies:    gromacs v 5 or later
# Assumptions:     Bilayer is symmetric, and contains at least one species with a glycerol backbone.
# Outputted files: the centered trajectory (name for this expected as the last input),
#                  molecule-wise electron density profiles, total electron density profile,
#                  the form factor.
#
# (*) example for pure POPC system:
# kuvaja:scriptsbyhsantila bb$ cat mappingMolecules.txt
# M_POPC_M	POPC	electrons_POPC.dat	mappingPOPCcharmm.txt
# M_SOL_M	TIP3	electrons_TIP3.dat	mappingSOLcharmm.txt
# kuvaja:scriptsbyhsantila bb$
# So columns are: [1] Molecul name in NMRlipids; [2] molecule name in this force field; [3] name of
# the file containing atomwise numbers of electrons, as required by gmx density; [4] name of the
# mappingfile between NMRlipids atom naming scheme and the atom names in this force field.

echo
# Check the inputs:
if [ $4 ]
then
  molMappFile=$1 # File containing the names of molecules in this FF, and the names of the corresponding electron files.
  tprFile=$2     # The input tpr-file.
  xtcFile=$3     # The input xtc-file.
  outFile=$4     # Name for the output xtc file.
  echo "Mapping: ${molMappFile}"
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
if [ -e foobar.map ]; then rm foobar.map; fi
for mol in $(awk '{print $1}' ${molMappFile}); do
    mapName=$(grep ${mol} ${molMappFile} | awk '{printf "%s\n",$4}')
    cat ${mapName} >> foobar.map
done
G1CH3name=`grep M_G1C[0-9]*_M foobar.map | tail -n1 | awk '{print $2}'`
echo 'The name of the CH3 carbon in sn-1 chain:' $G1CH3name
#
# Find the number of the CH3 atom in the last lipid:
echo -e "a ${G1CH3name}\nq" | gmx make_ndx -f $tprFile -o foo.ndx >& make_ndx.output
G1CH3number=`grep '[0-9]' foo.ndx | tail -n1 | awk '{print $NF}'`
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
echo '[ g3carbons ]' >> foo.ndx
for mol in $(awk '{print $1}' ${molMappFile}); do
    molName=$(grep ${mol} ${molMappFile} | awk '{printf "%s\n",$2}')
    mapName=$(grep ${mol} ${molMappFile} | awk '{printf "%s\n",$4}')
    numG3s=`grep -c 'M_.*G3_M' ${mapName}`
    if [ `grep -c 'M_.*G3_M' ${mapName}` != 0 ]
    then
      G1g3name=`grep 'M_.*G3_M' ${mapName} | awk '{print $2}'`
      echo 'The name of the g3 carbon(s) in' ${molName}':' ${G1g3name}
      intoGMXmake_ndx=`echo ${G1g3name} | sed 's/ / \| a /g'`
      echo -e "del 0-1000\na ${intoGMXmake_ndx} & r ${molName}\nq" | gmx make_ndx -f $tprFile -o foobar.ndx >& make_ndx.output
      grep -v '\[' foobar.ndx >> foo.ndx
      rm make_ndx.output foobar.ndx
    else
      echo 'No g3 carbons in' ${molName}'.'
    fi
done

# Center around CoM of g3 carbons, that is, center of bilayer, and make molecules whole:
echo "Centering around the center of mass of index group g3carbons..."
echo -e "g3carbons\nSystem" \
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
    echo -e "g3carbons\n${molName}" | \
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

echo
echo "Calculating form factor..."
slice=$(head -n2 electronDENSITY.xvg | awk '{dz=$1-prev;prev=$1}END{print dz}')

minbox=$(head -n 1 electronDENSITYsol.xvg | awk '{print $1}')
maxbox=$(tail -n 1 electronDENSITYsol.xvg | awk '{print $1}')
bulkDENS=$(awk -v minb=$minbox -v maxb=$maxbox '{if ($1<0.33+minb || $1>maxb-0.33)  {n=n+1; s=s+$2}} END{print s/n}' electronDENSITYsol.xvg)

cat electronDENSITY.xvg | awk -v slice=$slice -v bulkDENS=$bulkDENS 'BEGIN{scale=0.01;}{for(q=0;q<2000;q=q+1){F[q]=F[q]+($2-bulkDENS)*cos(scale*q*$1)*slice;}}END{for(q=0;q<1000;q=q+1){print 0.1*q*scale" "0.01*sqrt(F[q]*F[q])
}}' > Form_Factor_From_Simulation.dat
mv electronDENSITY.xvg Electron_Density_From_Simulation.dat
rm foo.ndx foobar.map

#cat Electron_Density_From_Simulation.dat #-- uncomment if want FF to STDOUT


#!/bin/bash
mappingFILE=mappingFILEpopc.txt
groOPpath=gro_OP.awk

HGGLYoutname=Headgroup_Glycerol_Order_Parameters_SimulationPOPC.dat
sn1outname=sn-1_Order_Parameters_SimulationPOPC.dat
sn2outname=sn-2_Order_Parameters_SimulationPOPC.dat

#THIS IS USED FOR UNITED ATOM MODELS
! [ -s trajINBOX.xtc ] && echo System | gmx trjconv -f trajectory.xtc -s topol.tpr -o trajINBOX.xtc -pbc res #-b $starttime -e $endtime
echo POPC | /home/samuli/Gromacs/gromacs402/bin/protonate -f trajINBOX.xtc -s topol.tpr -o runPROT.gro

####################
#THIS IS USED FOR ALL ATOM MODELS
####################
# choose one:
#LIPIDname=$(grep M_POPC_M $mappingFILE | awk '{printf "%5s\n",$2}')
#LIPIDname=$(grep M_DPPC_M $mappingFILE | awk '{printf "%5s\n",$2}')
#! [ -s runPROT.gro ] && echo $LIPIDname | gmx trjconv -n ../../../index.ndx -f ../trajectory.xtc -s ../topol.tpr -o runPROT.gro -pbc res

#CALCULATE HEADGROUP AND GLYCEROL ORDER PARAMETERS
rm $HGGLYoutname
echo 'label  Order_Parameter_1  Order_Parameter_2' >> $HGGLYoutname
#CALCULATE GAMMA ORDER PARAMETER
for((  j = 1 ;  j <= 3;  j=j+1  ))
do
Cname=$(grep M_G3N6C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3N6C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3N6C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H3name=$(grep M_G3N6C"$j"H3_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
H3op=$(awk -v Cname="$Cname" -v Hname="$H3name" -f $groOPpath runPROT.gro)
echo 0 $H1op $H2op $H3op >> $HGGLYoutname
done
Cname=$(grep M_G3C5_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3C5H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3C5H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
echo 1 $H1op $H2op 'nan' >> $HGGLYoutname
Cname=$(grep M_G3C4_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3C4H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3C4H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
echo 2 $H1op $H2op 'nan' >> $HGGLYoutname
Cname=$(grep M_G3_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
echo 3 $H1op $H2op 'nan' >> $HGGLYoutname
Cname=$(grep M_G2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G2H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
echo 4 $H1op 'nan' 'nan' >> $HGGLYoutname
Cname=$(grep M_G1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G1H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G1H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
echo 5 $H1op $H2op 'nan' >> $HGGLYoutname
#CALCULATE SN-1 ORDER PARAMETERS
rm $sn1outname
echo 'label  Order_Parameter_1  Order_Parameter_2' >> $sn1outname
for((  j = 3 ;  j <= 16;  j=j+1  ))
do
Cname=$(grep M_G1C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G1C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G1C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
label=$(($j-1))
echo $label $H1op $H2op >> $sn1outname
done
#CALCULATE SN-2 ORDER PARAMETERS
rm $sn2outname
echo 'label  Order_Parameter_1  Order_Parameter_2' >> $sn2outname
for((  j = 3 ;  j <= 18;  j=j+1  ))
do
Cname=$(grep M_G2C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G2C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G2C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1op=$(awk -v Cname="$Cname" -v Hname="$H1name" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="$Cname" -v Hname="$H2name" -f $groOPpath runPROT.gro)
label=$(($j-1))
echo $label $H1op $H2op >> $sn2outname
done
cat $sn2outname | awk '{if(!$3)print $1" "$2" nan";else print $0}' > tmp.dat
mv tmp.dat $sn2outname
#cd ..
#rm -r $tmpDIRname

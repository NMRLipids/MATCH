#!/bin/bash
mappingFILE=../mappingFILE.txt
groOPpath=gro_OP.awk

HGGLYoutname=../Headgroup_Glycerol_Order_Parameters_Simulation.dat
sn1outname=../sn-1_Order_Parameters_Simulation.dat
sn2outname=../sn-2_Order_Parameters_Simulation.dat

echo System | trjconv -f ../trajectory.xtc -s ../topol.tpr -o trajINBOX.xtc -pbc res #-b $starttime -e $endtime
echo PLA | /home/ollilas1/gromacs/gromacs402/bin/protonate -f trajINBOX.xtc -s ../topol.tpr -o runPROT.gro
#CALCULATE HEADGROUP AND GLYCEROL ORDER PARAMETERS
rm $HGGLYoutname
echo 'label  Order_Parameter_1  Order_Parameter_2' >> $HGGLYoutname
H1op=$(awk -v Cname="   C5" -v Hname="  H51" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="   C5" -v Hname="  H52" -f $groOPpath runPROT.gro)
echo 1 $H1op $H2op >> $HGGLYoutname
H1op=$(awk -v Cname="   C6" -v Hname="  H61" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="   C6" -v Hname="  H62" -f $groOPpath runPROT.gro)
echo 2 $H1op $H2op >> $HGGLYoutname
H1op=$(awk -v Cname="  C12" -v Hname=" H121" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="  C12" -v Hname=" H122" -f $groOPpath runPROT.gro)
echo 3 $H1op $H2op >> $HGGLYoutname
H1op=$(awk -v Cname="  C13" -v Hname=" H131" -f $groOPpath runPROT.gro)
echo 4 $H1op 'nan' >> $HGGLYoutname
H1op=$(awk -v Cname="  C32" -v Hname=" H321" -f $groOPpath runPROT.gro)
H2op=$(awk -v Cname="  C32" -v Hname=" H322" -f $groOPpath runPROT.gro)
echo 5 $H1op $H2op >> $HGGLYoutname
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
#cd ..
#rm -r $tmpDIRname

#!/bin/bash
mappingFILE=mappingFILE.txt

HGGLYoutname=defFILE.def
sn1outname=defFILE.def
sn2outname=defFILE.def

echo " assuming POPC -- choose other lipid-name through tweaks in the script"
LIPIDname=$(grep M_POPC_M $mappingFILE | awk '{printf "%5s\n",$2}')
#LIPIDname=$(grep M_DPPC_M $mappingFILE | awk '{printf "%5s\n",$2}')

#CALCULATE HEADGROUP AND GLYCEROL ORDER PARAMETERS
rm $HGGLYoutname
#CALCULATE GAMMA ORDER PARAMETER
for((  j = 1 ;  j <= 3;  j=j+1  ))
do
Cname=$(grep M_G3N6C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3N6C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3N6C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H3name=$(grep M_G3N6C"$j"H3_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo gamma${j}_1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname
echo gamma${j}_2  $LIPIDname  $Cname  $H2name >> $HGGLYoutname
echo gamma${j}_3  $LIPIDname  $Cname  $H3name >> $HGGLYoutname
done

Cname=$(grep M_G3C5_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3C5H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3C5H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo beta1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname
echo beta2  $LIPIDname  $Cname  $H2name >> $HGGLYoutname

Cname=$(grep M_G3C4_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3C4H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3C4H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo alpha1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname
echo alpha2  $LIPIDname  $Cname  $H2name >> $HGGLYoutname

Cname=$(grep M_G3_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G3H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G3H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo g3_1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname
echo g3_2  $LIPIDname  $Cname  $H2name >> $HGGLYoutname

Cname=$(grep M_G2_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G2H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo g2_1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname

Cname=$(grep M_G1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G1H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G1H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
echo g1_1  $LIPIDname  $Cname  $H1name >> $HGGLYoutname
echo g1_2  $LIPIDname  $Cname  $H2name >> $HGGLYoutname


#CALCULATE SN-1 ORDER PARAMETERS
#rm $sn1outname
for((  j = 3 ;  j <= 16;  j=j+1  ))
do
Cname=$(grep M_G1C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G1C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G1C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
label="palmitoyl_C"$(($j-1))
echo ${label}a $LIPIDname  $Cname  $H1name >> $sn1outname
echo ${label}b $LIPIDname  $Cname  $H2name >> $sn1outname
done

#CALCULATE SN-2 ORDER PARAMETERS
#rm $sn2outname
for((  j = 3 ;  j <= 18;  j=j+1  ))
do
Cname=$(grep M_G2C"$j"_M $mappingFILE | awk '{printf "%5s\n",$2}')
H1name=$(grep M_G2C"$j"H1_M $mappingFILE | awk '{printf "%5s\n",$2}')
H2name=$(grep M_G2C"$j"H2_M $mappingFILE | awk '{printf "%5s\n",$2}')
label="oleoyl_C"$(($j-1))
echo ${label}a $LIPIDname  $Cname  $H1name >> $sn2outname
echo ${label}b $LIPIDname  $Cname  $H2name >> $sn2outname
done


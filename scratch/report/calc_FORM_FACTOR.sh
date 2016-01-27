LIPIDname=$(grep M_POPC_M ../mappingFILE.txt | awk '{printf "%5s\n",$2}')
grep ' 1POPC' ../conf.gro | awk '{print $2}' > tmpEL.dat
cat tmpEL.dat | awk '{if($0~"C") print $1" =6";if($0~"H") print $1" =1"; if($0~"H") print $1" =1"; if($0~"O") print $1" =8"; if($0~"P") print $1" =15"; if($0~"N") print $1" =7";}END{print "OW =6";print "HW1 =1";print "HW2 =1";} 
' > electrons.dat
Enumber=$(cat electrons.dat | awk '{sum=sum+1}END{print sum}')
echo $Enumber >> tmp.dat
cat electrons.dat >> tmp.dat 
mv tmp.dat electrons.dat

echo non-Water System | trjconv -f ../trajectory.xtc -s ../topol.tpr -fit progressive -o ANALtraj.xtc
echo 0 | g_density -f ANALtraj.xtc -s ../topol.tpr -ei electrons.dat -dens electron -o electronDENSITY.xvg -xvg none -sl 100
transz=$(cat electronDENSITY.xvg | awk 'BEGIN{min=1000;}{if($2<min){min=$2; minx=$1;}}END{print minx}')
boxz=$(tail -n 1 electronDENSITY.xvg | awk '{print $1}')
slice=$(cat electronDENSITY.xvg | awk '{if(NR==2) print $1}')
cat electronDENSITY.xvg | awk -v transz=$transz '{print $1-transz" "$2}' > tmp.dat
cat tmp.dat | awk -v boxz=$boxz -v slice=$slice '{if($1<(-1)*boxz/2){print $1+boxz+slice" "$2}}' > tmp1.dat
cat tmp.dat | awk -v boxz=$boxz '{if($1>(-1)*boxz/2 && $1<boxz/2){print $1" "$2}}' > tmp2.dat
cat tmp.dat | awk -v boxz=$boxz '{if($1>boxz/2){print $1-boxz" "$2}}' > tmp3.dat
cat tmp3.dat tmp2.dat tmp1.dat > tmp4.dat
bulkDENS=$(tail -n 1 tmp4.dat | awk '{print $2}')
cat tmp4.dat | awk -v slice=$slice -v bulkDENS=$bulkDENS 'BEGIN{scale=0.01;}{for(q=0;q<1000;q=q+1){F[q]=F[q]+($2-bulkDENS)*cos(scale*q*$1)*slice;}}END{for(q=0;q<1000;q=q+1){print 0.1*q*scale" "0.01*sqrt(F[q]*F[q])
}}' > ../Form_Factor_From_Simulation.dat
cp tmp4.dat ../Electron_Density_From_Simulation.dat


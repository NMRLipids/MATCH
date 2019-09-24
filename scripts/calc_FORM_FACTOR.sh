~/NMRlipids/MATCH/scripts/centerTheBilayer.sh ./mappingFILE.txt ./topol.tpr ./traj.xtc centered.xtc
cp ./electronsLIPID.dat ./electrons.dat
SOLname=$(grep M_SOL_M ./mappingFILE.txt | awk '{printf "%5s\n",$2}')
LIPIDname=$(grep M_POPC_M ./mappingFILE.txt | awk '{printf "%5s\n",$2}')
echo $LIPIDname $SOLname | gmx density -f centered.xtc -s ./topol.tpr -ei electrons.dat -dens electron -o electronDENSITYsol.xvg -xvg none -sl 100 -center
echo $LIPIDname $LIPIDname | gmx density -f centered.xtc -s ./topol.tpr -ei electrons.dat -dens electron -o electronDENSITYlipid.xvg -xvg none -sl 100 -center
cp ./electronsCHOL.dat ./electrons.dat
CHOLname=$(grep M_CHOL_M ./mappingFILE.txt | awk '{printf "%5s\n",$2}')
echo $LIPIDname $CHOLname | gmx density -f centered.xtc -s ./topol.tpr -ei electrons.dat -dens electron -o electronDENSITYchol.xvg -xvg none -sl 100 -center
if [ -e "electronDENSITYchol.xvg" ];
then
    paste electronDENSITYsol.xvg electronDENSITYlipid.xvg electronDENSITYchol.xvg | awk '{print $1" "$2+$4+$6}' > electronDENSITYcent.xvg
else
    paste electronDENSITYsol.xvg electronDENSITYlipid.xvg | awk '{print $1" "$2+$4+$6}' > electronDENSITYcent.xvg
fi

slice=$(head -n2 electronDENSITYcent.xvg | awk '{dz=$1-prev;prev=$1}END{print dz}')

minbox=$(head -n 1 electronDENSITYsol.xvg | awk '{print $1}')
maxbox=$(tail -n 1 electronDENSITYsol.xvg | awk '{print $1}')
bulkDENS=$(awk -v minb=$minbox -v maxb=$maxbox '{if ($1<0.33+minb || $1>maxb-0.33)  {n=n+1; s=s+$2}} END{print s/n}' electronDENSITYsol.xvg)

cat electronDENSITY.xvg | awk -v slice=$slice-v bulkDENS=$bulkDENS 'BEGIN{scale=0.01;}{for(q=0;q<2000;q=q+1){Fa[q]=Fa[q]+($2-bulkDENS)*cos(scale*q*$1)*slice;Fb[q]=Fb[q]+($2-bulkDENS)*sin(scale*q*$1)*slice}}END{for(q=0;q<1000;q=q+1){print 0.1*q*scale" "sqrt(Fa[q]*Fa[q]+Fb[q]*Fb[q])
}}' > ./Form_Factor_From_Simulation.dat
cp electronDENSITYcent.xvg ./Electron_Density_From_Simulation.dat


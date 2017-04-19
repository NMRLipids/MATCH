#Location of data
#ELECTRONS_FILE=/wrk/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat
CALC_FORM_FACTOR=/mnt/scratch/scaledip/scripts/MATCH/scratch/report/calc_FORM_FACTOR.sh
REPORT_TEMPLATE=/mnt/scratch/scaledip/scripts/MATCH/scratch/report/report.tex
CALC_ORDER_PARAMETERS=/mnt/scratch/scaledip/scripts/MATCH/scratch/report/calc_ORDER_PARAMETERS.sh
GRO_OP=/mnt/scratch/scaledip/scripts/MATCH/scratch/report/gro_OP.awk

cp $REPORT_TEMPLATE ./

echo '0 0' > Electron_Density_From_Simulation.dat
echo '0 0' > Form_Factor_From_Simulation.dat
echo 'label  Order_Parameter_1  Order_Parameter_2
0 0 0' >  Headgroup_Glycerol_Order_Parameters_Simulation.dat
echo 'label  Order_Parameter_1  Order_Parameter_2
0 0 0' > sn-1_Order_Parameters_Simulation.dat
echo 'label  Order_Parameter_1  Order_Parameter_2
0 0 0' > sn-2_Order_Parameters_Simulation.dat

mkdir ANALYSISdirectory
#cp $TRAJECTORY ANALYSISdirectory/trajectory.trr
#cp $ELECTRONS_FILE ANALYSISdirectory/electrons.dat
cp $CALC_FORM_FACTOR ANALYSISdirectory/
cp $CALC_ORDER_PARAMETERS ANALYSISdirectory/
cp $GRO_OP ANALYSISdirectory/

#Calculate Form Factor from simulations
cd ANALYSISdirectory 
sh calc_FORM_FACTOR.sh
cd ..

#Update Report
#pdflatex report.tex

#Calculate order parameters
cp ffgmx2.hdb ANALYSISdirectory
cd ANALYSISdirectory
chmod a+x ./calc_ORDER_PARAMETERS.sh
./calc_ORDER_PARAMETERS.sh
cd ..

#Update Report
#pdflatex report.tex

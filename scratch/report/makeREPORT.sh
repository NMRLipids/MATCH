#Location of data
#ELECTRONS_FILE=/wrk/ollilas1/HGmodel/NMRlipids/NmrLipidsCholXray/scratch/POPCberger/electronsBERGER.dat
CALC_FORM_FACTOR=/wrk/ollilas1/HGmodel/NMRlipids/MATCH/scratch/report/calc_FORM_FACTOR.sh
REPORT_TEMPLATE=/wrk/ollilas1/HGmodel/NMRlipids/MATCH/scratch/report/report.tex
CALC_ORDER_PARAMETERS=/wrk/ollilas1/HGmodel/NMRlipids/MATCH/scratch/report/calc_ORDER_PARAMETERS.sh
GRO_OP=/wrk/ollilas1/HGmodel/NMRlipids/MATCH/scratch/report/gro_OP.awk

cp $REPORT_TEMPLATE ./

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
pdflatex report.tex

#Calculate order parameters
cp ffgmx2.hdb ANALYSISdirectory
cd ANALYSISdirectory
chmod a+x ./calc_ORDER_PARAMETERS.sh
./calc_ORDER_PARAMETERS.sh
cd ..

#Update Report
pdflatex report.tex

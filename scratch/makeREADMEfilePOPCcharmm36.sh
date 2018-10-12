system=Lipid_Bilayers
molecules=POPC
temperature=T300K
model=MODEL_CHARMM36
dataDOI=https://doi.org/10.5281/zenodo.1306799
trajectoryLINK1=https://zenodo.org/record/1306800/files/md_dt100_OK_centered.xtc
#trajectoryLINK2=https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolLINK=https://zenodo.org/record/1306800/files/md.tpr
confLINK=https://zenodo.org/record/1306800/files/step6.4_equilibration.gro
trajectoryNAME1=md_dt100_OK_centered.xtc
#trajectoryNAME2=md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolNAME=md.tpr
confNAME=step6.4_equilibration.gro
#defFILE=Headgroup_Glycerol_Order_Parameters_Simulation

mkdir -p ../Data/$system/$molecules/$temperature/$model
cd ../Data/$system/$molecules/$temperature/$model
echo '#Original data from' $dataDOI >> README.md
echo '\n' >> README.md
echo ''  >> README.md
echo 'wget ' $trajectoryLINK1  >> README.md
#echo 'wget ' $trajectoryLINK2  >> README.md
echo 'wget ' $topolLINK  >> README.md
echo 'wget ' $confLINK  >> README.md
echo ''  >> README.md
echo 'mv ' $topolNAME topol.tpr  >> README.md
echo 'mv ' $confNAME conf.gro  >> README.md
echo ''  >> README.md
echo 'mv ' $trajectoryNAME1 traj.xtc  >> README.md
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecules'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
#echo 'mv OrdPars.dat OrdPars'$molecules'_rep_1.dat'   >> README.md
echo ''   >> README.md
#echo 'mv ' $trajectoryNAME2 ' traj.xtc'   >> README.md
#echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
#echo 'mv OrdPars.dat OrdPars'$molecules'_rep_2.dat'   >> README.md
#echo ''   >> README.md
#echo 'paste OrdPars'$molecules'_rep_1.dat OrdPars'$molecules'_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk'    >> README.md

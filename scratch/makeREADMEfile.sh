system=Lipid_Bilayers
molecules=POPE
temperature=T310K
model=Slipids
dataDOI=https://doi.org/10.5281/zenodo.1293812
trajectoryLINK1=https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1_100-200ns.xtc
trajectoryLINK2=https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolLINK=https://zenodo.org/record/1293813/files/for-md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.tpr
trajectoryNAME1=md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1_100-200ns.xtc
trajectoryNAME2=md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolNAME=for-md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v1.tpr
defFILE=Headgroup_Glycerol_Order_Parameters_Simulation

mkdir -p ../Data/$system/$molecules/$temperature/$model
cd ../Data/$system/$molecules/$temperature/$model
echo '#Original data from' $dataDOI >> README.md
echo '\n' >> README.md
echo ''  >> README.md
echo 'wget ' $trajectoryLINK1  >> README.md
echo 'wget ' $trajectoryLINK2  >> README.md
echo 'wget ' $topolLINK  >> README.md
echo ''  >> README.md
echo 'mv ' $topolNAME topol.tpr  >> README.md
echo ''  >> README.md
echo 'mv ' $trajectoryNAME1 traj.xtc  >> README.md
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecules'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecules'_rep_1.dat'   >> README.md
echo ''   >> README.md
echo 'mv ' $trajectoryNAME2 ' traj.xtc'   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecules'_rep_2.dat'   >> README.md
echo ''   >> README.md
echo 'paste OrdPars'$molecules'_rep_1.dat OrdPars'$molecules'_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk'    >> README.md

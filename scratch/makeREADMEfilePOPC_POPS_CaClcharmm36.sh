system=Lipid_Bilayers
molecule1=POPS
molecule2=popc
molecule3=150mMCaCl
fractionOFmolecule2=83
temperature=T298K
model=MODEL_CHARMM36
dataDOI=https://doi.org/10.5281/zenodo.2532248
trajectoryLINK1=https://zenodo.org/record/2532249/files/run.wrapped.xtc
#trajectoryLINK2=https://zenodo.org/record/1293813/files/md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolLINK=https://zenodo.org/record/2532249/files/step7_1.tpr
confLINK=https://zenodo.org/record/2532249/files/step7_1.part0002.gro
trajectoryNAME1=run.wrapped.xtc
#trajectoryNAME2=md_POPE_hexagonal_membrane_Slipids_CORRECT_200ns_v2_100-200ns.xtc
topolNAME=step7_1.tpr
confNAME=step7_1.part0002.gro
#defFILE=Headgroup_Glycerol_Order_Parameters_Simulation

mkdir -p ../Data/$system/$molecule1'+'$fractionOFmolecule2'%'$molecule2'+'$molecule3/$temperature/$model
cd ../Data/$system/$molecule1'+'$fractionOFmolecule2'%'$molecule2'+'$molecule3/$temperature/$model
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
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecule1'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecule1'.dat'   >> README.md
echo ''   >> README.md
#echo 'mv ' $trajectoryNAME2 ' traj.xtc'   >> README.md
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecule2'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecule2'.dat'   >> README.md
echo ''   >> README.md
#echo 'paste OrdPars'$molecules'_rep_1.dat OrdPars'$molecules'_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk'    >> README.md

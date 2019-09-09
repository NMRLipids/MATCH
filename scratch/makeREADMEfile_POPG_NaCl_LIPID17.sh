system=Lipid_Bilayers
molecule=POPG
molecule3=150mNaCl
fractionOFmolecule=100
lipid=500lipids
temperature=T310K
model=MODEL_LIPID17
dataDOI=https://zenodo.org/record/2573905#.XLcD8EN7net
topolLINK=https://zenodo.org/record/2573905/files/md_01.tpr
trajectoryLINK=https://zenodo.org/record/2573905/files/dm_400_500_POPG_amber.xtc
confLINK=https://zenodo.org/record/2573905/files/amber.top
trajectoryNAME1=dm_400_500_POPG_amber.xtc
topolNAME=md_01.tpr
confNAME=
#defFILE=Headgroup_Glycerol_Order_Parameters_Simulation

mkdir -p ../Data/$system/$molecule'+'$molecule3/$temperature/$model'_'$lipid
cd ../Data/$system/$molecule'+'$molecule3/$temperature/$model'_'$lipid
echo '#Original data from' $dataDOI >> README.md
echo '\n' >> README.md
echo ''  >> README.md
echo 'wget ' $trajectoryLINK >> README.md
echo 'wget ' $topolLINK  >> README.md
echo 'wget ' $confLINK  >> README.md
echo ''  >> README.md
echo 'mv ' $topolNAME topol.tpr  >> README.md
echo 'mv ' $confNAME conf.gro  >> README.md
echo ''  >> README.md
echo 'mv ' $trajectoryNAME1 traj.xtc  >> README.md
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecule'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecule'.dat'   >> README.md
echo ''   >> README.md

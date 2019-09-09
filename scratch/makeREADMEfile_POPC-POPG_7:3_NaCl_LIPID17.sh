system=Lipid_Bilayers
molecule1=POPG
molecule2=POPC
molecule3=150mNaCl
fractionOFmolecule=30
lipid=500lipids
temperature=T310K
model=MODEL_LIPID17
dataDOI=https://zenodo.org/record/2585523#.XL8a70N7nes
trajectoryLINK=https://zenodo.org/record/2585523/files/dm_popc_popg_7_3_lipid17.xtc
topolLINK=https://zenodo.org/record/2585523/files/md_08.tpr
confLINK=https://zenodo.org/record/2585523/files/amber.prmtop
trajectoryNAME1=dm_popc_popg_7_3_lipid17.xtc
topolNAME=md_08.tpr
confNAME=conf.gro
#defFILE=Headgroup_Glycerol_Order_Parameters_Simulation


mkdir -p ../Data/$system/$molecule1'+'$fractionOFmolecule'%'$molecule2'+'$molecule3/$temperature/$model
cd ../Data/$system/$molecule1'+'$fractionOFmolecule'%'$molecule2'+'$molecule3/$temperature/$model

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
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecule1'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecule1'.dat'   >> README.md
echo ''   >> README.md
echo 'mv ' $trajectoryNAME1 traj.xtc  >> README.md
echo 'cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_'$model'_'$molecule2'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecule2'.dat'   >> README.md
echo ''   >> README.md



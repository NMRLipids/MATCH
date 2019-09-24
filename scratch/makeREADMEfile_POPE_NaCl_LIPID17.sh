system=Lipid_Bilayers
molecule=POPE
molecule3=150mNaCl
fractionOFmolecule=100
lipid=500lipids
temperature=T310K
model=MODEL_LIPID17
dataDOI=https://zenodo.org/record/2577305#.XLiDK0N7mHk
topolLINK=https://zenodo.org/record/2577305/files/md_09.tpr
trajectoryLINK=https://zenodo.org/record/2577305/files/m_400_500_POPE_amber.xtc
confLINK=https://zenodo.org/record/2577305/files/topol.top
trajectoryNAME1=m_400_500_POPE_amber.xtc
topolNAME=md_09.tpr
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

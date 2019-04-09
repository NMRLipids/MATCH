system=Lipid_Bilayers
molecule=POPG
molecule3=150mNaCl
fractionOFmolecule=100
lipid=500lipids
temperature=T310K
model=MODEL_CHARMM36
dataDOI=https://zenodo.org/record/2573531#.XKyvykN7mHl
trajectoryLINK=https://zenodo.org/record/2573531/files/m_400_500_POPG_charmm.xtc
topolLINK=https://zenodo.org/record/2573531/files/topol.top
confLINK=
trajectoryNAME1=m_400_500_POPG_charmm.xtc
topolNAME=topol.tpr
confNAME=conf.gro
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



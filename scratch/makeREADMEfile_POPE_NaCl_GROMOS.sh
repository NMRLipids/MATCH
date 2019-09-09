system=Lipid_Bilayers
molecule1=POPE
molecule3=150mNaCl
lipid=500lipids
temperature=T310K
model=MODEL_GROMOS-CKP
dataDOI=https://zenodo.org/record/2574491#.XMhOVUN7nes
trajectoryLINK=https://zenodo.org/record/2574491/files/m_400_500_POPE_gromos.xtc
topolLINK=https://zenodo.org/record/2574491/files/md_04.tpr
confLINK=https://zenodo.org/record/2574491/files/topol.top
trajectoryNAME1=m_400_500_POPE_gromos.xtc
topolNAME=md_04.tpr
confNAME=conf.gro
#defFILE=Headgroup_Glycerol_Order_Parameters_Simulation


mkdir -p ../Data/$system/$molecule1'+'$molecule3/$temperature/$model
cd ../Data/$system/$molecule1'+'$molecule3/$temperature/$model

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



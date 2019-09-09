system=Lipid_Bilayers
molecule1=POPC
molecule3=150mNaCl
lipid=500lipids
temperature=T310K
model=MODEL_GROMOS-CKP
dataDOI=https://zenodo.org/record/2574691#.XMhB90N7nes
trajectoryLINK=https://zenodo.org/record/2574691/files/m_400_500_POPC_gromos.xtc
topolLINK=https://zenodo.org/record/2574691/files/md_010.tpr
confLINK=https://zenodo.org/record/2574691/files/topol.top
trajectoryNAME1=m_400_500_POPC_gromos.xtc
topolNAME=md_010.tpr
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



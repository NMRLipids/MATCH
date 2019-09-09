system=Lipid_Bilayers
molecule=POPC
molecule3=150mNaCl
fractionOFmolecule=100
lipid=500lipids
temperature=T310K
model=MODEL_SLIPID
dataDOI=https://zenodo.org/record/2574689#.XKczT0N7nLB
trajectoryLINK=https://zenodo.org/record/2574689/files/m_400_500_POPC_slipid.xtc
topolLINK=https://zenodo.org/record/2574689/files/md_04.tpr
confLINK=
trajectoryNAME1=md_400_500_POPC_slipid.xtc
topolNAME=md_04.tpr
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

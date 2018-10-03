system=Lipid_Bilayers
molecules=POPE
temperature=T313K
model=GROMOS43A1-S3
dataDOI=https://doi.org/10.5281/zenodo.1293761
trajectoryLINK1=https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v1_100-200ns.xtc
trajectoryLINK2=https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v2_100-200ns.xtc
topolLINK=https://zenodo.org/record/1293762/files/for-md-pope_43A1-S3_313K_v1.tpr
trajectoryNAME1=md-pope_43A1-S3_313K_v1_100-200ns.xtc
trajectoryNAME2=md-pope_43A1-S3_313K_v2_100-200ns.xtc
topolNAME=for-md-pope_43A1-S3_313K_v1.tpr
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
echo 'cp ' $defFILE$molecules'.def' defFILE.def   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecules'_rep1_.dat'   >> README.md
echo ''   >> README.md
echo 'mv ' $trajectoryNAME2 ' traj.xtc'   >> README.md
echo 'sh ../../../../../scripts/order_parameters_calculate.sh'   >> README.md
echo 'mv OrdPars.dat OrdPars'$molecules'_rep2_.dat'   >> README.md
echo ''   >> README.md
echo 'paste OrdPar'$molecules'_rep_1.dat OrdPar'$molecules'_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk'    >> README.md

#Original data from https://doi.org/10.5281/zenodo.1293761



wget  https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v1_100-200ns.xtc
wget  https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v2_100-200ns.xtc
wget  https://zenodo.org/record/1293762/files/for-md-pope_43A1-S3_313K_v1.tpr

mv  for-md-pope_43A1-S3_313K_v1.tpr topol.tpr

mv  md-pope_43A1-S3_313K_v1_100-200ns.xtc traj.xtc
cp  Headgroup_Glycerol_Order_Parameters_SimulationPOPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep1_.dat

mv  md-pope_43A1-S3_313K_v2_100-200ns.xtc  traj.xtc
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE_rep2_.dat

paste OrdParPOPE_rep_1.dat OrdParPOPE_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk

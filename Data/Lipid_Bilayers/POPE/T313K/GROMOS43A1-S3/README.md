#Original data from https://doi.org/10.5281/zenodo.1293761



wget  https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v1_100-200ns.xtc
wget  https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v2_100-200ns.xtc
wget  https://zenodo.org/record/1293762/files/for-md-pope_43A1-S3_313K_v1.tpr
wget  https://zenodo.org/record/1293762/files/md-pope_43A1-S3_313K_v1.gro

mv  for-md-pope_43A1-S3_313K_v1.tpr topol.tpr
mv md-pope_43A1-S3_313K_v1.gro conf.gro

mv  md-pope_43A1-S3_313K_v1_100-200ns.xtc traj1.xtc
mv  md-pope_43A1-S3_313K_v2_100-200ns.xtc  traj2.xtc
cp  Headgroup_Glycerol_Order_Parameters_SimulationPOPE.def defFILE.def

python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj1.xtc -d ../../../../../scripts/orderParm_defs/order_parameter_definitions_GROMOS43A1-S3_POPE.def -l GROMOS43A1_S3_POPE -o OrdParPOPE_rep_1.dat  conf.gro
python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj2.xtc -d ../../../../../scripts/orderParm_defs/order_parameter_definitions_GROMOS43A1-S3_POPE.def -l GROMOS43A1_S3_POPE -o OrdParPOPE_rep_2.dat  conf.gro 

#paste OrdParPOPE_rep_1.dat OrdParPOPE_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk
paste OrdParPOPE_rep_1.dat.jmelcr_style.out OrdParPOPE_rep_2.dat.jmelcr_style.out  | awk -f ../../../../../scripts/averageOVERdata.awk > OrdParPOPE_av.dat

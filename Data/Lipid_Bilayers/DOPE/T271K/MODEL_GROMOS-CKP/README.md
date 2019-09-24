# Original data https://doi.org/10.5281/zenodo.1293940

wget https://zenodo.org/record/1293941/files/md_DOPE_CKP_new_NH3_PME_verlet_v1_100-500ns.xtc
wget https://zenodo.org/record/1293941/files/md_DOPE_CKP_new_NH3_PME_verlet_v2_100-500ns.xtc
wget https://zenodo.org/record/1293941/files/md_DOPE_CKP_new_NH3_PME_verlet_v1.gro

mv md_DOPE_CKP_new_NH3_PME_verlet_v1_100-500ns.xtc traj1.xtc
mv md_DOPE_CKP_new_NH3_PME_verlet_v2_100-500ns.xtc traj2.xtc
mv md_DOPE_CKP_new_NH3_PME_verlet_v1.gro conf.gro

python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj1.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_DOPE.def -l Berger_DOPE conf.gro -o OrdParPOPE_rep_1.dat
python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj2.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_DOPE.def -l Berger_DOPE conf.gro -o OrdParPOPE_rep_2.dat
paste OrdParPOPE_rep_1.dat.jmelcr_style.out OrdParPOPE_rep_2.dat.jmelcr_style.out  | awk -f ../../../../../scripts/averageOVERdata.awk > OrdParPOPE_av.dat

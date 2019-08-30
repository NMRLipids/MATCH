# Original data https://doi.org/10.5281/zenodo.1293904

#wget https://zenodo.org/record/1293905/files/md-DOPE_berger_271K_repH2_v1_100-300ns.xtc
#wget https://zenodo.org/record/1293905/files/md-DOPE_berger_271K_repH2_v2_100-300ns.xtc
#wget https://zenodo.org/record/1293905/files/md-DOPE_berger_271K_repH2_v1.gro

#mv md-DOPE_berger_271K_repH2_v1_100-300ns.xtc traj1.xtc
#mv md-DOPE_berger_271K_repH2_v2_100-300ns.xtc traj2.xtc
#mv md-DOPE_berger_271K_repH2_v1.gro conf.gro

python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj1.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_DOPE.def -l Berger_DOPE conf.gro -o OrdParPOPE_rep_1.dat
python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x traj2.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_DOPE.def -l Berger_DOPE conf.gro -o OrdParPOPE_rep_2.dat

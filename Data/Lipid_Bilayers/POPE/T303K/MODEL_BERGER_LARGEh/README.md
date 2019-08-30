# Original data https://doi.org/10.5281/zenodo.1293891

wget https://zenodo.org/record/1293891/files/md-POPE_berger_303K_repH2_v1_100-200ns.xtc
wget https://zenodo.org/record/1293891/files/md-POPE_berger_303K_repH2_v2_100-200ns.xtc
wget https://zenodo.org/record/1293891/files/md-POPE_berger_303K_repH2_v1.gro

python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x md-POPE_berger_303K_repH2_v1_100-200ns.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_POPE.def -l Berger_POPE md-POPE_berger_303K_repH2_v1.gro -o OrdParPOPE_rep_1.dat
python3 /home/osollila/LipidDataBank/buildH/buildH_calcOP.py -x md-POPE_berger_303K_repH2_v2_100-200ns.xtc -d /home/osollila/LipidDataBank/buildH/Berger_POPC_test_case/order_parameter_definitions_MODEL_Berger_POPE.def -l Berger_POPE md-POPE_berger_303K_repH2_v1.gro -o OrdParPOPE_rep_2.dat
paste OrdParPOPE_rep_1.dat.jmelcr_style.out OrdParPOPE_rep_2.dat.jmelcr_style.out  | awk -f ../../../../../scripts/averageOVERdata.awk > OrdParPOPE_av.dat

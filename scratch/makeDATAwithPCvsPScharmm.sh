echo '#[POPS]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPS_a1   error     POPS_a2     error       POPS_b1   error    POPS_b2   error'
echo 0.17'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh ~/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc/T298K/MODEL_CHARMM36/
echo ''
echo 0.5'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh ~/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+50%popc/T298K/MODEL_CHARMM36/
echo ''


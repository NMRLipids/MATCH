echo '#[POPE]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPE_a1   error     POPE_a2     error       POPE_b1   error    POPE_b2   error'
echo 0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/samuli/NMRlipids/MATCH/Data/Lipid_Bilayers/POPC/T300K/MODEL_CHARMM36/
echo ''
echo 0.5'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/samuli/NMRlipids/MATCH/Data/Lipid_Bilayers/POPC+50%POPE/T300K/MODEL_CHARMM36/
echo ''


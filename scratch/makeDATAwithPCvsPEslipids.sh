echo '#[POPG]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPG_a1   error     POPG_a2     error       POPG_b1   error    POPG_b2   error'
echo 0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPC+150mNaCl/T310K/MODEL_SLIPID_500lipids/
echo ''
echo 0.3'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+30%POPC+150mNaCl/T310K/MODEL_SLIPIDS/
echo ''
echo 1.0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+150mNaCl/T310K/MODEL_SLIPID_500lipids/
echo ''


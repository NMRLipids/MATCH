echo '#[POPE]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPE_a1   error     POPE_a2     error       POPE_b1   error    POPE_b2   error'
echo 0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata4.sh /home/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPC/T298K/MODEL_SLIPIDS/OrdPars.dat
echo ''
#echo 0.3'     '   | tr -d "\n"
#sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+30%POPC+150mNaCl/T310K/MODEL_SLIPIDS/
#echo ''
echo 1.0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata4.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPE+50%POPC/T298K/MODEL_SLIPIDS/OrdParsPOPC.dat
sh ~/NMRlipids/MATCH/scripts/grepOPdata4.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPE+50%POPC/T298K/MODEL_SLIPIDS/OrdParsPOPE.dat
echo ''


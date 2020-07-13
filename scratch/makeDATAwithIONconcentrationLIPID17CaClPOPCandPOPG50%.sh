echo '#[CaCl]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPG_a1   error     POPG_a2     error       POPG_b   error'
echo 0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+50%POPC/T298K/MODEL_LIPID17/
for i in 100 1000 
do
    echo $i'   '   | tr -d "\n"
    sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPG+50%POPC+"$i"mMCaCl/T298K/MODEL_LIPID17/
done

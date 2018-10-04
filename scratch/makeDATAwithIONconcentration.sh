echo '#[CaCl]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPS_a1   error     POPS_a2     error       POPS_b   error'
echo 0'     '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc/T298K/MODEL_LIPID17/
for i in 500 1000 2000
do
    echo $i'   '   | tr -d "\n"
    sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc+"$i"mMCaCl/T298K/MODEL_LIPID17/
done

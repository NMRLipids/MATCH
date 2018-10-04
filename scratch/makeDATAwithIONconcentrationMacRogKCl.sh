echo '#[CaCl]    POPC_a1   error      POPC_a2   error       POPC_b1   error      POPC_b2     error    POPS_a1   error     POPS_a2     error       POPS_b   error'
echo 0'         '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc/T298K/MODEL_MACROG/
echo 500'      '   | tr -d "\n"
sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc+500mMKCl/T298K/MODEL_MACROG/
for i in 1000 2000 3000
do 
    echo $i'      '   | tr -d "\n"
    sh ~/NMRlipids/MATCH/scripts/grepOPdata.sh /home/local/osollila/NMRlipids/MATCH/Data/Lipid_Bilayers/POPS+83%popc+"$i"mMKCl/T298/MODEL_MACROG/
done

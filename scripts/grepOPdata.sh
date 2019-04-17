directory=$1 
grep alpha1 $directory/OrdParsPOPC.dat | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep alpha2 $directory/OrdParsPOPC.dat  | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep beta1 $directory/OrdParsPOPC.dat | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep beta2 $directory/OrdParsPOPC.dat | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep alpha1 $directory/OrdParsPOPG.dat | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep alpha2 $directory/OrdParsPOPG.dat | awk '{print $5"    "$7"   "}' | tr -d "\n"
grep beta $directory/OrdParsPOPG.dat | awk '{print $5"    "$7"    "}' 

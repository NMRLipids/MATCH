directory=$1 
grep alpha1 $directory/OrdParsPOPC.dat | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep alpha2 $directory/OrdParsPOPC.dat  | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep beta1 $directory/OrdParsPOPC.dat | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep beta2 $directory/OrdParsPOPC.dat | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep alpha1 $directory/OrdParsPOPS.dat | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep alpha2 $directory/OrdParsPOPS.dat | awk '{print $2"  "$3"  "}' | tr -d "\n"
grep beta $directory/OrdParsPOPS.dat | awk '{print $2"  "$3"   "}' 

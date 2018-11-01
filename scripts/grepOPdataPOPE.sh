directory=$1 
grep beta1  OrdParsPOPE.dat | awk '{print "1  "$2"  "$3"  "}' 
grep beta2  OrdParsPOPE.dat | awk '{print "1  "$2"  "$3"  "}' 
grep alpha1 OrdParsPOPE.dat | awk '{print "2  "$2"  "$3"  "}' 
grep alpha2 OrdParsPOPE.dat | awk '{print "2  "$2"  "$3"  "}'
grep g3_1   OrdParsPOPE.dat | awk '{print "3  "$2"  "$3"  "}' 
grep g3_2   OrdParsPOPE.dat | awk '{print "3  "$2"  "$3"  "}'
grep g2_1   OrdParsPOPE.dat | awk '{print "4  "$2"  "$3"  "}'
grep g1_1   OrdParsPOPE.dat | awk '{print "5  "$2"  "$3"  "}' 
grep g1_2   OrdParsPOPE.dat | awk '{print "5  "$2"  "$3"  "}'



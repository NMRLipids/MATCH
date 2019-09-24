directory=$1 
grep beta1  $directory | awk '{print "1  "$5"  "$7"  "}' 
grep beta2  $directory | awk '{print "1  "$5"  "$7"  "}' 
grep alpha1 $directory | awk '{print "2  "$5"  "$7"  "}' 
grep alpha2 $directory | awk '{print "2  "$5"  "$7"  "}'
grep g3_1   $directory | awk '{print "3  "$5"  "$7"  "}' 
grep g3_2   $directory | awk '{print "3  "$5"  "$7"  "}'
grep g2_1   $directory | awk '{print "4  "$5"  "$7"  "}'
grep g1_1   $directory | awk '{print "5  "$5"  "$7"  "}' 
grep g1_2   $directory | awk '{print "5  "$5"  "$7"  "}'



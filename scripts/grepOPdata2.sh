directory=$1 
grep alpha1 $directory | awk '{print $2"    -   "}' | tr -d "\n"
grep alpha2 $directory  | awk '{print $2"   -   "}' | tr -d "\n"
grep beta1 $directory | awk '{print $2"    -   "}' | tr -d "\n"
grep beta2 $directory | awk '{print $2"    -   "}' | tr -d "\n"

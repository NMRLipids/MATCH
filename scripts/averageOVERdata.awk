{
    if(NR==1){
	print "#Average over two replicas \n           #order parameter   sem"
    };
    if(NR>2){
	print $1"     "($5+$12)/2"          "($7+$14)/2
    }
}

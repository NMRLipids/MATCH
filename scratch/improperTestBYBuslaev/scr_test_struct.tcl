# ---------------------------------------------------------
#
# VMD script for checking the chirality of glycerol
# in lipid molecules
#
# ---------------------------------------------------------
#
# Created by P. Buslaev, Gushchin lab, MIPT 03.08.2017
# Contacts: P. Buslaev  - pbuslaev@phystech.edu
#           I. Gushchin - ivan.gushchin@phystech.edu
#
# ---------------------------------------------------------
#
# Usage example: 
#	
#	improper top P C1 C2 O21 C3
#
# ---------------------------------------------------------

proc measure_impr {mol resid n1 n2 n3 n4} {
	set imp {}

	set sel [atomselect $mol "resid $resid and name $n1"]
	lappend imp [$sel get index]
	set sel [atomselect $mol "resid $resid and name $n2"]
	lappend imp [$sel get index]
	set sel [atomselect $mol "resid $resid and name $n3"]
	lappend imp [$sel get index]
	set sel [atomselect $mol "resid $resid and name $n4"]
	lappend imp [$sel get index]

	return [measure imprp $imp]
}

# mol is molecule ID in VMD
# p n1 n2 n3 n4 are the corresponding names of atoms:
#
#    |
# -- P -- O11 -- C1 -- C2 -- C3
#    |                 |     |
#                      O21   O31
#                      |     |
#
# in this case: p = P, n1 = C1, n2 = C2, n3 = O21, n4 = C3

proc improper {mol p n1 n2 n3 n4 {fname "improper.dat"} } {
	set sel [atomselect $mol "name $p"]
	set rs [$sel get resid]
	set f [open $fname "w"]
	set count 0
	set n 0
	set problems {}
	foreach  i $rs {
		incr n
		if {[measure_impr $mol $i $n1 $n2 $n3 $n4] > 0} {
			incr count
			lappend problems $i
		}
	}
	puts $f "Number of good impropers: [expr $n - $count]"
	puts $f "Number of bad impropers: $count"
	if {$count > 0} {
		puts $f "Incorrect improper residue IDs: $problems"
	}
	close $f
}

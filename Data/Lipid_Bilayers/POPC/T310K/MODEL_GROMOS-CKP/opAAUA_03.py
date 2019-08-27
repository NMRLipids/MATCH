#!/usr/bin/env python
#
# Please, contact to Angel.Pineiro at usc.es for any question or comment
# Version May 9, 2019
#

import numpy as np
from MDAnalysis import *
import optparse
import fileinput
from math import *
import cStringIO

desc='Calculation of order parameters from a pdb file or an xtc trajectory. The atom list is taken from the topology itp file of the target molecule. Example: python2.7 opAAUA.py -p 1.pdb -i POPC.itp -r POPC -a ignH -u "C29 C210"'

#Examples:
#Single pdb file ignoring the explicit H atoms:    python2.7 opAAUA.py -p 1.pdb -i POPC.itp -r POPC -a ignH -u "C29 C210"
#Whole trajectory considering explicit atoms:      python2.7 opAAUA.py -p popc.pdb -i POPC.itp -r POPC -a AA -x popc.xtc
#Whole trajectory ignoring the explicit H atoms:   python2.7 opAAUA.py -p popc.pdb -i POPC.itp -r POPC -a ignH -u "C29 C210" -x popc.xtc

def permuta(string):
    aux=string[-1]
    for i in range(0,len(string)-1,1): aux=aux+string[i]
    return aux

def ReadITPfile(itp_file):
    control=-1; atoms=[]; bonds=[]
    for line in fileinput.input(itp_file) :
	if line.strip() :
            fields=line.split()
	    if (fields[0]=='[') and (fields[2]==']') and (fields[1]=="atomtypes" or fields[1]=="defaults") :
		control=0
	    elif (fields[0]=='[') and (fields[2]==']') and (fields[1]=="atoms") :
		control=1
	    elif (fields[0]=='[') and (fields[2]==']') and (fields[1]=="bonds") :
		control=2
	    elif (fields[0]=='[') and (fields[2]==']') and (fields[1]=="pairs") :
		control=3
	    elif (fields[0]=='[') and (fields[2]==']') and (fields[1]=="angles") :
		control=4
	    # write to "atoms" and "bonds"
	    if (control==1) and (fields[0][0]!=';') and (fields[0]!='[') and (len(fields)>1):
		atoms.append(fields)
	    elif (control==2) and (fields[0][0]!=';') and (fields[0]!='[') and (len(fields)>1):
		bonds.append(fields)
    return [atoms, bonds]

def GetCatoms_array(itp, AA_UA, unsat):
    Catoms=GetCatoms(itp, AA_UA, unsat)
    C2atoms=GetC2atoms(Catoms)
    Carbon=['C', 'c']; aux=[]
    for c in range (0,len(Catoms),1): 
        if Catoms[c][0][0] in Carbon and len(Catoms[c])>1: aux.append(Catoms[c])
    Catoms=aux; aux=[]
    for c in range (0,len(C2atoms),1): 
        if C2atoms[c][0][0] in Carbon: aux.append(C2atoms[c])
    C2atoms=aux; Catoms_per=Get_Catoms_per(Catoms); C2atoms_per=Get_Catoms_per(C2atoms)
    return [Catoms, Catoms_per, C2atoms, C2atoms_per]

def GetCatoms(itp, AA_UA, unsat): # list of heavy atoms and the atoms to which they are bound, except Hydrogens if "-a ignH"
    atoms=itp[0]; bonds=itp[1]; Catoms=[]; Catoms_per=[]; Hydrogen=['H', 'h']; UA=['ignH', 'IGNH']
    for a in range (0, len(atoms), 1):
        if (atoms[a][1][0] not in Hydrogen): # Assuming that type starting by H is a Hydrogen atom
            Catom_i=[]; Catom_i.append(atoms[a][4]); aid=atoms[a][0]
            for b in range (0, len(bonds), 1):
                if (bonds[b][0]==aid): aid2=bonds[b][1]
                elif (bonds[b][1]==aid): aid2=bonds[b][0]
                else: aid2=-1
                if (aid2>0):
                    for aa in range (0, len(atoms), 1):
                        if (atoms[aa][0]==aid2): # Assuming that type starting by H is a Hydrogen atom
                            if (AA_UA not in UA) and (atoms[aa][1][0] in Hydrogen): Catom_i.append(atoms[aa][4])
                            elif (AA_UA in UA) and (atoms[aa][1][0] not in Hydrogen): Catom_i.append(atoms[aa][4])
            Catoms.append(Catom_i)
    return Catoms

def Get_Catoms_per(Catoms): # gromacs writes atomnames in the trajetory files with this permutation when the final character is a number
    Catoms_per=[]; numbers=['0','1','2','3','4','5','6','7','8','9']
    for i in range(0,len(Catoms),1):
        Catom_i_per=[]
        for j in range(0,len(Catoms[i]),1):
            if (len(Catoms[i][j]))>3 and Catoms[i][j][-1] in numbers: Catom_i_per.append(permuta(Catoms[i][j]))
            else: Catom_i_per.append(Catoms[i][j])
        Catoms_per.append(Catom_i_per)
    return Catoms_per

def GetC2atoms(Catoms): # list of second neighbours for C-atoms (only heavy atoms)
    C2atoms=[]; Hydrogen=['H', 'h']
    for a in range (0, len(Catoms), 1):
        C2atom_i=[]; C2atom_i.append(Catoms[a][0])
        for aa in range (0, len(Catoms), 1):
            if (Catoms[a][0] in Catoms[aa][1:]):
                for i in range (1, len(Catoms[aa]), 1):
                    if (Catoms[aa][i]!=Catoms[a][0]) and (Catoms[aa][i][0] not in Hydrogen): C2atom_i.append(Catoms[aa][i])
        C2atoms.append(C2atom_i)
    return C2atoms

def GetOP(Catoms_array, trj, begin, end, skip, AA_UA, unsatlist, xtc_file):
    op=[]; Catoms=Catoms_array[0]; Catoms_per=Catoms_array[1]; C2atoms=Catoms_array[2]; C2atoms_per=Catoms_array[3]
    for c in range (0,len(Catoms),1):
        if len(Catoms[c])>1:
            H=[]; X=[]; X2=[]; op_c=[]; fr=-1
            Cname= Catoms[c][0]; Cname_per=Catoms_per[c][0]; Cnames=[Cname, Cname_per]
            print "\nAtom ", Cname, "\tRunning over frames ",
################################
            if (xtc_file=='none'): # Single pdb file
                C=(trj.select_atoms("name "+Catoms[c][0]+" or name "+Catoms_per[c][0]).positions)
                for i in range (1,len(Catoms[c]),1):
                    if (AA_UA=='AA'): H.append(trj.select_atoms("name "+Catoms[c][i]+" or name "+Catoms_per[c][i]).positions)##### AA
                    else: X.append(trj.select_atoms("name "+Catoms[c][i]+" or name "+Catoms_per[c][i]).positions)
                for i in range (1,len(C2atoms[c]),1):
                    X2.append(trj.select_atoms("name "+C2atoms[c][i]+" or name "+C2atoms_per[c][i]).positions)
                C=np.array(C); X=np.array(X); X2=np.array(X2); H=np.array(H)
                if (AA_UA!='AA'):
                    for j in range (0,len(X[0]),1): # running over residues
                        op_c.append(GetOP_iUA(j,C,X,X2,Catoms,C2atoms,Cnames,unsatlist))
                else:
                    for j in range (0,len(H[0]),1): # running over residues
                        op_c.append(GetOP_iAA(j,C,H[:,j,:],Catoms,Cnames))
                op.append(avop(Catoms[c], op_c)) # Average values
            else: # Trajectory
                for frame in trj.trajectory[begin:end:skip]: # Iterate over frames 
                    fr=fr+1; H=[]; X=[]; X2=[]#; op_f=[];
                    print ".",
                    C=(trj.select_atoms("name "+Catoms[c][0]+" or name "+Catoms_per[c][0]).positions)
                    for i in range (1,len(Catoms[c]),1):
                        if (AA_UA=='AA'): H.append(trj.select_atoms("name "+Catoms[c][i]+" or name "+Catoms_per[c][i]).positions)##### AA
                        else: X.append(trj.select_atoms("name "+Catoms[c][i]+" or name "+Catoms_per[c][i]).positions)
                    for i in range (1,len(C2atoms[c]),1):
                        X2.append(trj.select_atoms("name "+C2atoms[c][i]+" or name "+C2atoms_per[c][i]).positions)
                    if (AA_UA!='AA'): 
                        for j in range (0,len(X[0]),1): # running over residues
                            op_c.append(GetOP_iUA(j,C,X,X2,Catoms,C2atoms,Cnames,unsatlist))
                    elif len(H)>0:
                        H=np.array(H)
                        for j in range (0,len(H[0]),1): # running over residues
                            op_c.append(GetOP_iAA(j,C,H[:,j,:],Catoms,Cnames))
                    #op_c.append(np.average(op_f, axis=0))
                op.append(avop(Catoms[c], op_c)) # Average values
    return op

def GetOP_iUA(j,C,X,X2,Catoms,C2atoms,Cnames,unsatlist):
    C=np.array(C); X=np.array(X); X2=np.array(X2)
    if (Cnames[0] in unsatlist) or (Cnames[1] in unsatlist): H=GetH_unsat(Cnames, C[j],X[:,j,:],X2[:,j,:],Catoms,unsatlist)
    else: H=GetH(Cnames,C[j],X[:,j,:],X2[:,j,:],Catoms,C2atoms)
    op_i=[]
    for i in range (0,len(H), 1):
        #if Cname[0] in Carbon: # print hydrogen atoms in pdb format for validation
        #    print("%4s  %5i %4s %4s %4i    %8.3f%8.3f%8.3f%6.2f%6.2f" % ("ATOM", i, "X"+str(i), Cname, 2, H[i][0], H[i][1], H[i][2], 1, 0)) 
        op_i.append(GetopH(C[j],H[i]))
    op_av=np.average(op_i)
    if (len(H)): op_i.append(op_av)
    if (len(op_i)==2): op_i.insert(1,0)
    if (len(op_i)==3): op_i.insert(2,0)
    if (len(op_i)==0): op_i=[0,0,0,0]
    return op_i

def GetOP_iAA(j,C,H,Catoms,Cnames):
    C=np.array(C); H=np.array(H); op_i=[]
    for i in range (0,len(H), 1):
        #if Cname[0] in Carbon: # print hydrogen atoms in pdb format for validation
        #    print("%4s  %5i %4s %4s %4i    %8.3f%8.3f%8.3f%6.2f%6.2f" % ("ATOM", i, "X"+str(i), Cname, 2, H[i][0], H[i][1], H[i][2], 1, 0)) 
        op_i.append(GetopH(C[j],H[i]))
    op_av=np.average(op_i)
    if (len(H)): op_i.append(op_av)
    if (len(op_i)==2): op_i.insert(1,0)
    if (len(op_i)==3): op_i.insert(2,0)
    if (len(op_i)==0): op_i=[0,0,0,0]
    return op_i

def GetopH(C,H):
    d=np.linalg.norm(C-H)
    dz=H[2]-C[2]; cos=dz/d
    return 0.5*(3*cos*cos-1)

def GetH(Cnames,C,X,X2,Catoms,C2atoms):
    sin=0.81664156; cos=0.57714519;
    cos71=np.cos(71*np.pi/180); sin71=np.sin(71*np.pi/180) # Constants
    V2=C; V1=X[0]; H=[]
    if (len(X)==1): 
        C2=X2[0] # Terminal C atom
        dv12=V2-V1; dv12=dv12/np.linalg.norm(dv12) # Unitary vector in the direction from X to C
        dv2C2=V2-C2; dv2C2=dv2C2/np.linalg.norm(dv2C2) # Unitary vector in the direction perpendicular to the C[i-2]-C[i-1]-C[i] plane
        Vp=np.cross(dv12, dv2C2); Vp=Vp/np.linalg.norm(Vp) # Unitary vector perpendicular to dv12 (and to the C[i-2]-C[i-1]-C[i] plane)
        Vp2=np.cross(dv12, Vp); Vp2=Vp2/np.linalg.norm(Vp2) # Unitary vector perpendicular to dv12 and to Vp
        H3=V2+(cos71*dv12-sin71*Vp2) # H position in the plane formed by the C-chain and the vector joining C and X (109 deg with this vector)
        V3=H3; H.append(H3)
    elif (len(X)==2): V3=X[1]
    if (len(X)<3):
        dv12=V1-V2; dv23=V2-V3; zV=V1-V3 # Definition of vectors in the direction of X,Y,Z
        xV=np.cross(dv12, dv23); yV=np.cross(xV, zV); 
        xV=xV/np.linalg.norm(xV); yV=yV/np.linalg.norm(yV); zV=zV/np.linalg.norm(zV)
        H1=sin*xV+cos*yV; H2=-sin*xV+cos*yV; H1=H1+V2; H2=H2+V2; # Coordinates of the hydrogen atoms
        H.append(H2); H.append(H1)
    elif (len(X)==3):
        V1=C; V2=X[0]; V3=X[1]; V4=X[2]
        dv12=V2-V1; dv13=V3-V1; dv14=V4-V1;
        dv12=dv12/np.linalg.norm(dv12); dv13=dv13/np.linalg.norm(dv13); dv14=dv14/np.linalg.norm(dv14)
        H1=-(dv12+dv13+dv14)+V1; H.append(H1); 
    return H 

def GetH_unsat(Cnames,C,X,X2,Catoms,unsatlist):
    for a in range (0,len(Catoms),1):
        if (Catoms[a][0] in Cnames):
            C2name=Catoms[a][1]; C3name=Catoms[a][2]; C2name_per=permuta(C2name); C3name_per=permuta(C3name);
            C2=X[0]; C3=X[1]
    if (C2name in unsatlist) or (C2name_per in unsatlist):
        aux=C2name; C2name=C3name; C3name=aux; aux=C2; C2=C3; C3=aux
    sin=0.5; cos=float(sqrt(3.)/2.); # Constants
    V1=C2; V2=C3; V3=C # Coordinates of the three carbon atoms. The double bond is between V2 and V3
    dv12=V1-V2; dv32=zV=V3-V2; dv13=V1-V3 # Definition of vectors in the direction of X,Y,Z
    xV=np.cross(dv12, dv13); yV=np.cross(xV, zV)
    xV=xV/np.linalg.norm(xV); yV=yV/np.linalg.norm(yV); zV=zV/np.linalg.norm(zV)
    H=-cos*yV+sin*zV; H=H+V3;  # Coordinates of the hydrogen atom
    return [H]

def avop(Catom_i, op_c):
    op_c=np.array(op_c); k=-1; c_i=[]
    c_i.append(Catom_i[0])
    for j in range(0,4,1):
        std=np.std(op_c[:,j]); avg=np.average(op_c[:,j])
        c_i.append([avg, std, std/np.sqrt(len(op_c[:,j]))])
    return c_i

def write_results(op, outfile, Catoms):
    buf = cStringIO.StringIO()
    print >> buf, "Atom_name  Hydrogen\tOP\t      STD\t   STDmean"
    j=0; Carbon=['C', 'c']
    for i in range(0,len(op),1): 
        if Catoms[i][0][0] in Carbon:
            j=j+1
            if op[i][1][0]:
                print >> buf, "%7s\t%8s  %10.5f\t%10.5f\t%10.5f" % (Catoms[i][0], "HR", op[i][1][0], op[i][1][1], op[i][1][2])   
                if op[i][2][0]: print >> buf, "%7s\t%8s  %10.5f\t%10.5f\t%10.5f" % ("", "HS", op[i][2][0], op[i][2][1], op[i][2][2])   
                if op[i][3][0]: print >> buf, "%7s\t%8s  %10.5f\t%10.5f\t%10.5f" % ("", "HT", op[i][3][0], op[i][3][1], op[i][3][2])   
                print >> buf, "%7s\t%8s  %10.5f\t%10.5f\t%10.5f\n" % ("", "AVG", op[i][4][0], op[i][4][1], op[i][4][2])    
    print(buf.getvalue())
    fout=open(outfile, "w")
    fout.write(buf.getvalue())
    fout.close()

def main() :
    parser = optparse.OptionParser(description=desc, version='%prog version 1.0')
    parser.add_option('-p', '--pdb_file', help='input pdb file', action='store')
    parser.add_option('-x', '--xtc_file', help='input xtc file', action='store')
    parser.add_option('-i', '--itp_file', help='input itp file', action='store')
    parser.add_option('-b', '--begin', help='begin: first frame to be analyzed', action='store')
    parser.add_option('-e', '--end', help='end: last frame to be analyzed', action='store')
    parser.add_option('-s', '--skip', help='skip: only write every nr-th frame', action='store')
    parser.add_option('-a', '--AA_ignH', help='AA for All-Atoms and ignH to ignore all explicit H atoms', action='store')
    parser.add_option('-u', '--unsat', help='list of unsaturated carbon atoms, only if "-a ignH"', action='store')
    parser.add_option('-o', '--outfile', help='output file name', action='store')
    parser.set_defaults(pdb_file='file.pdb', itp_file='file.itp', xtc_file='none', begin=0, end=-1, skip=1, AA_ignH='ignH', unsat='', outfile='out.op')
    options, arguments = parser.parse_args()

#**************************************************************************************
    pdb_file=str(options.pdb_file)
    xtc_file=str(options.xtc_file)
    itp_file=str(options.itp_file)
    begin=int(options.begin)
    end=int(options.end)
    skip=int(options.skip)
    outfile=str(options.outfile)
    AA_UA=str(options.AA_ignH)
    unsat=str(options.unsat)
    unsatlist=unsat.split()

    if (xtc_file=='none'): trj=Universe(pdb_file)
    else: trj=Universe(pdb_file, xtc_file)
    if (end==-1): end=trj.trajectory.n_frames

    itp=ReadITPfile(itp_file)
    resname=itp[0][0][3]
    Catoms_array=GetCatoms_array(itp, AA_UA, unsat)
    op=GetOP(Catoms_array, trj, begin, end, skip, AA_UA, unsatlist, xtc_file)

    print "\n\n\nAveraging order parameters for a total of ", trj.residues.n_residues, "lipids and ", trj.trajectory.n_frames, " frames\n"
    write_results(op, outfile, Catoms_array[0])

if __name__=="__main__" :
    main()

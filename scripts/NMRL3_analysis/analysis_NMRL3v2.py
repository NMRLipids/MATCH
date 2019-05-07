import numpy as np
import sys 
import random
import time
import math

#----------------------------------------------------------
def read_expdata(datafile):
	opf=open(datafile,'r')
	lines=opf.readlines()
	data=[]
	for line in lines:
		if '#' in line:
			continue
		if 'label' in line:
			continue
		parts=line.split()
	
		data.append([float(p) for p in parts])
	n=len(data)
	m=len(data[1])
	#data_out=np.empty((n, m))
	data_out=np.array(data)

	return data_out

#--------------------------------------------------------
def find_extrema(data, q_min):
	maxs=[]	
	mins=[]
	Npoints=len(data)
	data_grad=np.gradient(data[:,1])

	print q_min

	for i in range(0,Npoints-2):

		v1=data_grad[i]
		v2=data_grad[i+1]

		if v1>=0 and v2 < 0 and data[i,0]>q_min:
			maxs.append(i)
			print i, data[i,0], data[i,1]
		if v1<=0 and v2 > 0 and data[i,0]>q_min:
			mins.append(i)
			print i, data[i,0], data[i,1]

	return maxs, mins

#-----------------------------------------------------------
def read_simOP(datafile):
	opf=open(datafile,'r')
	lines=opf.readlines()

	op=[]
	op_stem=[]
	op_names=[]

	for line in lines:
		if '#' in line:
			continue
		
		parts=line.split()
		op_names.append(parts[0])
		op.append(float(parts[4]))
		op_stem.append(float(parts[6]))
	return op_names, np.array(op), np.array(op_stem)

#------------------------------------------------------------
# Following functions are molecule region spesific, cause some OPs have to be placed into the data matrix multiple times while others show splitting
#------------------------------------------------------------
def read_hdgr_glys(datafile):
	data=[]
	try:	
		opf=open(datafile,'r')
	except:
		return data
	lines=opf.readlines()

	for line in lines:
		if '#' in line:
			continue
		if 'label' in line:
			continue
		parts=line.split()
		if int(float(parts[0]))==0:
			for i in range(0,9):
				data.append(float(parts[1]))

		if int(float(parts[0]))>=1 and  int(parts[0])<=3:
			for i in range(0,2):
				data.append(float(parts[1]))	
		if int(float(parts[0]))==4:
			data.append(float(parts[1]))
		if int(float(parts[0]))==5:
			data.append(float(parts[1]))	
			data.append(float(parts[2]))
		
	
	return np.array(data)
#------------------------------------------------------------
def read_sn1(datafile):
	data=[]
	try:	
		opf=open(datafile,'r')
	except:
		return data
	lines=opf.readlines()

	for line in lines:
		if '#' in line:
			continue 
		if 'label' in line:
			continue
		parts=line.split()
		if int(float(parts[0]))==16:
			data.append(float(parts[1]))	
			data.append(float(parts[1]))
			data.append(float(parts[1]))
			continue
		data.append(float(parts[1]))
		data.append(float(parts[1]))
		
	return np.array(data)
	
#------------------------------------------------------------
def read_sn2(datafile):
	data=[]
	try:	
		opf=open(datafile,'r')
	except:
		return data
	lines=opf.readlines()

	for line in lines:
		if '#' in line:
			continue 
		if 'label' in line:
			continue
		parts=line.split()
		if int(float(parts[0]))==2:
			data.append(float(parts[1]))	
			data.append(float(parts[2]))
			continue
		if int(float(parts[0]))==9 or int(float(parts[0]))==10:
			data.append(float(parts[1]))	
			continue
		if int(float(parts[0]))==18:
			data.append(float(parts[1]))	
			data.append(float(parts[1]))
			data.append(float(parts[1]))
			continue
		data.append(float(parts[1]))
		data.append(float(parts[1]))
	return np.array(data)
#-------------------------------------------------------------


#This version does not require same amount of simulated OPs and experimental data. Instead, it skips the OP if it is not found in the "OPsimufile". IMPORTANT: remember to remove the corresponding experimental value too.
#usage: python analysis_NMRL3v2.py
#requires: the files listed below 
Fsimufile='Form_Factor_From_Simulation.dat'
Fexpfile='Form_Factor_From_Experiments.dat'
#ops.txt contains simulated results for all the ops, named in the way defined in the "keys" section below
#IMPORTANT: the order has to be the same in which the experimental data is. Headgroup, glys, sn1, sn2
OPsimufile='ops.txt'
#can also give no file as: OPexp_sn1=''
OPexp_h_n_g='Headgroup_Glycerol_Order_Parameters_Experiments.dat'
OPexp_sn2='sn-2_Order_Parameters_Experiments.dat'
OPexp_sn1='sn-1_Order_Parameters_Experiments.dat' 

#For now, using the q_values of 2 first max and min, and the relation of peak heights (1 to 2 and 2 to 3) to characterise the FF
#NOTE: find_extrema only works if the data is smooth.
fexp=read_expdata(Fexpfile)
(maxs, mins) = find_extrema(fexp,0)
Fdata_exp=[]
Fdata_exp.append(fexp[maxs[0]][1]/fexp[maxs[1]][1])
Fdata_exp.append(fexp[maxs[1]][1]/fexp[maxs[2]][1])	
Fdata_exp.append(fexp[maxs[0]][0])
Fdata_exp.append(fexp[maxs[1]][0])
Fdata_exp.append(fexp[mins[0]][0])
Fdata_exp.append(fexp[mins[1]][0])

q_min=fexp[0][0]

Fdata_sim=[]
fsim=read_expdata(Fsimufile)
(maxs, mins) = find_extrema(fsim,q_min)
Fdata_sim.append(fsim[maxs[0]][1]/fsim[maxs[1]][1])
Fdata_sim.append(fsim[maxs[1]][1]/fsim[maxs[2]][1])	
Fdata_sim.append(fsim[maxs[0]][0])
Fdata_sim.append(fsim[maxs[1]][0])
Fdata_sim.append(fsim[mins[0]][0])
Fdata_sim.append(fsim[mins[1]][0])


fit_ff=0	
fitnessf=open('fitness.txt','w')


for i in range(0,len(Fdata_sim)):
	print Fdata_exp[i], Fdata_sim[i]
	fit_ff=fit_ff+(Fdata_exp[i]-Fdata_sim[i])**2
fit_ff=math.sqrt(fit_ff/float(len(Fdata_sim)))	
fitnessf.write("fitness from FF "+str(fit_ff)+'\n')		

# now continuing with the calculation of OP fitnesses

#collectin the data for the different sections of the molecule. If file missing, returns an empty array
datahg=read_hdgr_glys(OPexp_h_n_g)
datasn1=read_sn1(OPexp_sn1)
datasn2=read_sn2(OPexp_sn2)

exp_op=np.concatenate((datahg,datasn1,datasn2), axis=0)
opnames, sim_op, sim_stem=read_simOP(OPsimufile)



#keys defined here
keys_sn1=[]
keys_sn2=[]
keys_headgr=['gamma_C13a',
'gamma_C13b',
'gamma_C13c',
'gamma_C14a',
'gamma_C14b',
'gamma_C14c',
'gamma_C15a',
'gamma_C15b',
'gamma_C15c',
'beta1',
'beta2',
'alpha1',
'alpha2']
keys_glys=['g3_1',
'g3_2',
'g2_1',
'g1_1']
keys_h_n_g=keys_headgr+keys_glys

for i in range(2,18):
	key_sn1='palmitoyl_C'+str(i)
	key_sn2='oleoyl_C'+str(i)
	if i==10 or i==9:
		keys_sn1.append(key_sn1+'a')
		keys_sn1.append(key_sn1+'b')
		keys_sn2.append(key_sn2+'a')
		continue	
	if i<16:
		keys_sn1.append(key_sn1+'a')
		keys_sn1.append(key_sn1+'b')
	keys_sn2.append(key_sn2+'a')	
	keys_sn2.append(key_sn2+'b')

#and for the last atoms
	
key_sn1='palmitoyl_C16'
key_sn2='oleoyl_C18'
keys_sn1.append(key_sn1+'a')
keys_sn1.append(key_sn1+'b')
keys_sn1.append(key_sn1+'c')
keys_sn2.append(key_sn2+'a')	
keys_sn2.append(key_sn2+'b')
keys_sn2.append(key_sn2+'c')

#creates the key list for all	
keys_all=keys_h_n_g+keys_sn1+keys_sn2

fit_s=0
fit_sn1=0
fit_sn2=0
fit_headgr=0
fit_glys=0
fit_h_n_g=0

#Will assign negative fitness if none of the keys in the region where simulated, zero if the experimental datafile is empty

n=0
if datasn1!=[]:
	for key in keys_sn1:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue
		
		fit_sn1=fit_sn1+(exp_op[indx]-sim_op[indx])**2
	if n==0:
		fit_sn1=-1
	else:
		fit_sn1=math.sqrt(fit_sn1/n)

n=0
if datasn2!=[]:
	for key in keys_sn2:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue
		fit_sn2=fit_sn2+(exp_op[indx]-sim_op[indx])**2
	if n==0:
		fit_sn2=-1
	else:
		fit_sn2=math.sqrt(fit_sn2/n)

if len(datahg)!=0:
	n=0
	for key in keys_headgr:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue

		fit_headgr=fit_headgr+(exp_op[indx]-sim_op[indx])**2
	if n==0:
		fit_headgr=-1
	else:
		fit_headgr=math.sqrt(fit_headgr/n)

	n=0
	for key in keys_glys:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue

		fit_glys=fit_glys+(exp_op[indx]-sim_op[indx])**2
	if n==0:
		fit_glys=-1
	else:
		fit_glys=math.sqrt(fit_glys/n)

	n=0
	for key in keys_h_n_g:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue
		
		fit_h_n_g=fit_h_n_g+(exp_op[indx]-sim_op[indx])**2
	if n==0:
		fit_h_n_g=-1
	else:
		fit_h_n_g=math.sqrt(fit_h_n_g/n)

n=0
if len(exp_op)!=0:
	for key in keys_all:
		try:
			indx=opnames.index(key)
			n=n+1
		except:
			continue
		fit_s=fit_s+(exp_op[indx]-sim_op[indx])**2
		fitnessf.write(opnames[indx]+" "+str(exp_op[indx])+" "+str(sim_op[indx])+" "+str(sim_stem[indx])+" "+str(abs(sim_op[indx]-exp_op[indx]))+"\n")
	if n==0:
		fit_s=-1
	else:	
		fit_s=math.sqrt(fit_s/n)
	
fitnessf.write("fitness from headgr "+str(fit_headgr)+'\n')	
fitnessf.write("fitness from glys "+str(fit_headgr)+'\n')	
fitnessf.write("fitness from headgr+glys "+str(fit_h_n_g)+'\n')	
fitnessf.write("fitness from sn1 "+str(fit_sn1)+'\n')	
fitnessf.write("fitness from sn2 "+str(fit_sn2)+'\n')	
fitnessf.write("fitness from all OPs "+str(fit_s)+'\n')	
fitnessf.write("fitness OPs+FF "+str(fit_ff+fit_s)+'\n')
fitnessf.close()


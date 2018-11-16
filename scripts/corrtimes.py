import sys
import numpy as np
from scipy import optimize

#script for calculating effective correlation time and R1 by H. Antila, with help from S. Ollila and T. Ferreira
#usage: python corrtimes.py rotac.dat opvalue
#files needed: rotac.dat = the rotation correlation ftio that corresponds to the opvalue. Expects 2 column format "time" "f_value"



def read_data(datafile):
#for reading the correlation function data
	opf=open(datafile,'r')
	lines=opf.readlines()
	data_times=[]
	data_F=[]
	for line in lines:
		if '#' in line:
			continue
		if 'label' in line:
			continue
		parts=line.split()
		data_F.append(float(parts[1]))
		data_times.append(float(parts[0]))

	#data_out=np.empty((n, m))
	data_Fout=np.array(data_F)
	times_out=np.array(data_times)
	return data_Fout, times_out


def main(argv):


	#read in simulation data from gromacs g_rotacf
	corrfile=argv[1]	
	corrF, Stimes=read_data(corrfile)
	#read in OP value
	OP=float(argv[2])

	#normalized correlation fuction
	NcorrF=(corrF-OP**2)/(1-OP**2);

	#Create correlation times from 1ps to 1micros
	Ctimes=10**np.arange(-1,6+0.1,0.1)
	

	#First, no forcing the plateou
	#create exponential functions and put them into a matrix	
	n=len(Stimes)
	m=len(Ctimes)
	Cexp_mat=np.zeros((n,m))
	
	for i in range(0,n):
		for j in range(0,m):
			Cexp_mat[i,j]=np.exp(-Stimes[i]/Ctimes[j])

	Coeffs,res=optimize.nnls(Cexp_mat, NcorrF)	

	#Effective correlation time from components, in units of sec

		
	Teff=sum(Coeffs*Ctimes*0.001*10**(-9))
	
	print "Teff from exponential fit", Teff

	# calculate t_eff from area
	dt=Stimes[2]-Stimes[1]
	pos=np.argmax(NcorrF<0);

	if pos > 0:
		tau_eff_area=sum(NcorrF[0:pos])*dt*0.001*10**(-9);
	else:
		tau_eff_area=sum(NcorrF)*dt*0.001*10**(-9);
	
	print "Teff from area", tau_eff_area
	print sum(NcorrF)
	print pos
	print NcorrF[pos]
	print dt
		
	#Constants for calculating R1

	wc=2*np.pi*125.76*10**6;
	wh=wc/0.25;


	#changin the unit of time permanently
	Ctimes=Ctimes*0.001*10**(-9);
	
	

	J0=0
	J1=0
	J2=0
	Jw1=0
	
 	for i in range(0,m):
		w=wh-wc
		
		J0=J0+2*Coeffs[i]*Ctimes[i]/(1.0+w*w*Ctimes[i]*Ctimes[i])
	
	
		w=wc
		J1=J1+2*Coeffs[i]*Ctimes[i]/(1.0+w*w*Ctimes[i]*Ctimes[i])

		w=wc+wh
		J2=J2+2*Coeffs[i]*Ctimes[i]/(1.0+w*w*Ctimes[i]*Ctimes[i])
		
		
		
	#print J0, J1, J2
	#R1=(2.1*10**9)*(J0+3*J1+6*J2)
	R1=(22000*2*np.pi)**2/20.0*(1-OP**2)*(J0+3*J1+6*J2)
	#print "R1", R1
	
	print "R1", R1

if __name__ == "__main__":
	sys.exit(main(sys.argv))



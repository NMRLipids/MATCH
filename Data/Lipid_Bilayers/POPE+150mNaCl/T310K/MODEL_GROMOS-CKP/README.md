#Data from https://doi.org/10.5281/zenodo.2574490

wget https://zenodo.org/record/2574491/files/m_400_500_POPE_gromos.xtc
wget https://zenodo.org/record/2574491/files/md_04.tpr

gmx density -f m_400_500_POPE_gromos.xtc -s md_04.tpr -dens number -o IONdens.xvg -center -ng 2

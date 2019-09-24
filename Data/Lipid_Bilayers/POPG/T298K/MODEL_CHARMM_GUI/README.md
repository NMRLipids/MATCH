# Data available from https://doi.org/10.5281/zenodo.1011095

wget https://zenodo.org/record/1011096/files/run2.xtc
wget https://zenodo.org/record/1011096/files/run2.tpr
wget https://zenodo.org/record/1011096/files/run.gro

mv run2.tpr topol.tpr
mv run.gro conf.gro
echo System | gmx trjconv -f run2.xtc -s topol.tpr -o traj.xtc -b 15000
cp Headgroup_Glycerol_Order_Parameters_SimulationPOPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh

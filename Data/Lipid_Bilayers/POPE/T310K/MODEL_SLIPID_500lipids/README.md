#Original data from https://zenodo.org/record/3231342#.XR3XDiZ7nes



wget  https://zenodo.org/record/3231342/files/pope_slipid_400_500_pbc.xtc
wget  https://zenodo.org/record/3231342/files/topol.tpr
wget  https://zenodo.org/record/3231342/files/pope_slipid_500ns_pbc.gro

mv  topol.tpr topol.tpr
mv  pope_slipid_400_500_pbc.gro conf.gro

mv  pope_slipid_400_500_pbc.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

sh ~/NMRlipids/MATCH/scripts/grepOPdata3.sh OrdPars.dat  > Headgroup_Glycerol_Order_Parameters_Simulation.dat

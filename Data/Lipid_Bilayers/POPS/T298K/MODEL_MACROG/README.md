#Data from http://nmrlipids.blogspot.com/2017/03/nmrlipids-iv-headgroup-glycerol.html?showComment=1524081965753#c5190176912574180774 by T. Piggot
#Original data from https://doi.org/10.5281/zenodo.1283334



wget  https://zenodo.org/record/1283335/files/md-MacRog_POPS_fix_tails_298K_v1_400-500ns_skip10.xtc
wget  https://zenodo.org/record/1283335/files/md-MacRog_POPS_fix_tails_298K_v2_400-500ns_skip10.xtc
wget  https://zenodo.org/record/1283335/files/for-md-MacRog_POPS_fix_tails_298K_v1.tpr
wget  https://zenodo.org/record/1283335/files/md-MacRog_POPS_fix_tails_298K_v1.gro

mv  for-md-MacRog_POPS_fix_tails_298K_v1.tpr topol.tpr
mv  md-MacRog_POPS_fix_tails_298K_v1.gro conf.gro

mv  md-MacRog_POPS_fix_tails_298K_v1_400-500ns_skip10.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_MACROG_POPS.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPS_rep_1.dat

mv  md-MacRog_POPS_fix_tails_298K_v2_400-500ns_skip10.xtc  traj.xtc
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPS_rep_2.dat

paste OrdParsPOPS_rep_1.dat OrdParsPOPS_rep_2.dat | awk -f ../../../../../scripts/averageOVERdata.awk

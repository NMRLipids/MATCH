#Original data from https://zenodo.org/record/2579675#.XK76anVKjRZ



wget  https://zenodo.org/record/2579675/files/dm_popg_pope_3_1_slipid.xtc
wget  https://zenodo.org/record/2579675/files/md_08.tpr
wget 
wget  https://zenodo.org/record/2579675/files/topol.top

mv  md_08.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popg_pope_3_1_slipid.xtc
 traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  m_400_500_PG_PE_1_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat

#Original data from https://zenodo.org/record/2579675#.XK76anVKjRZ



wget  https://zenodo.org/record/2579675/files/dm_popg_pope_3_1_slipid.xtc
wget  https://zenodo.org/record/2579675/files/md_08.tpr
wget 
wget  https://zenodo.org/record/2579675/files/topol.top

mv  md_08.tpr topol.tpr
mv  conf.gro conf.gro

mv  dm_popg_pope_3_1_slipid.xtc  traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPG.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPG.dat

mv  m_400_500_PG_PE_1_3_slipid.xtc traj.xtc
cp  ../../../../../scripts/orderParm_defs/order_parameter_definitions_MODEL_SLIPID_POPE.def defFILE.def
sh ../../../../../scripts/order_parameters_calculate.sh
mv OrdPars.dat OrdParsPOPE.dat


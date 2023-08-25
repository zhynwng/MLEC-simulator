#!/usr/bin/bash


for config in "2+1" "14+6" "21+9"
do
  echo "Running SLEC_LOCAL_CP $config"
  bash slec_local_cp_$config.sh
done

for config in "28+12"
do
  echo "Running SLEC_LOCAL_CP $config"
  bash slec_local_cp_$config.sh
done


for config in "2+1" "14+6" "21+9"
do
  echo "Running SLEC_NET_CP $config"
  bash slec_net_cp_$config.sh
done

for config in "5+1_5+1" "10+2_17+3" "17+3_17+3"
do
  echo "Running MLEC_C_C $config"
  bash mlec_c_c_$config.sh
done

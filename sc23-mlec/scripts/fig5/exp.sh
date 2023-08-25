#!/usr/bin/bash

export PATH="/home/$USER/anaconda3/bin:$PATH"

cd ~/mlec-sim/src/theory

for policy in MLEC_C_C MLEC_C_D MLEC_D_C MLEC_D_D
do
    echo "Starting to compute burst tolerance for $policy"
    python burst_theory.py -k_net=10 -p_net=2 -k_local=17 -p_local=3 -placement=$policy -total_drives=57600 -drives_per_rack=960 -drives_per_diskgroup=120
    echo "$policy Done"
    echo "===================="
done
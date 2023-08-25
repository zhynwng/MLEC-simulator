#!/usr/bin/bash

export PATH="/home/$USER/anaconda3/bin:$PATH"

echo "Running experiments for..."

echo "CP-CP"
bash mcc.sh

echo "CP-DP"
bash mcd.sh

echo "DP-CP"
bash mdc.sh

echo "DP-DP"
bash mdd.sh

echo "done"
# Figure 8: Cross-rack network traffic

## Introduction
In this instruction, we compute PDL under correlated failures that corresponds to figure 8 in the paper. First, run the following command: 

```
source ~/.bashrc 
cd ~/MLEC-simulator-doc/scripts/fig8
bash exp.sh
```

## Fetch Results
Then we fetch the results from the MLEC simulator to ~/MLEC-simulator-doc/data/fig8

```
mkdir ~/MLEC-simulator-doc/data/fig8
cp ~/mlec-sim/src/results/fig8/scheme-0.dat ~/MLEC-simulator-doc/data/fig8/scheme-0.dat
cp ~/mlec-sim/src/results/fig8/scheme-1.dat ~/MLEC-simulator-doc/data/fig8/scheme-1.dat
cp ~/mlec-sim/src/results/fig8/scheme-2.dat ~/MLEC-simulator-doc/data/fig8/scheme-2.dat
cp ~/mlec-sim/src/results/fig8/scheme-3.dat ~/MLEC-simulator-doc/data/fig8/scheme-3.dat
```

# Generate Plots

Then, we generate the plots based on the simulation result
```
mkdir -p ~/MLEC-simulator-doc/plots/fig8
cd ~/MLEC-simulator-doc/
python3 scripts/fig8/plot.py plots/fig8/fig8.png
```

You can then check the plots in the directory "~/MLEC-simulator-doc/plots/fig5"
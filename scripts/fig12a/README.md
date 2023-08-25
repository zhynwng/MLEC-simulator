# Figure 10: Durability

## Introduction
In this simulation, we reproduce the left part of Figure 12: C/C vs SLEC-CP. Since the simulation takes 3-4 hours to run, we run it in the background using "tmux". First, run the following command: 

```
cd ~/MLEC-simulator-doc/scripts/fig12a
tmux new-session -d -s fig12a-session 'bash exp.sh &> fig12a.log; tmux kill-session -t fig12a-session'
```

## Wait Results
Usually, the simulations takes 3-5 hours. You can check the progress via the command:
```
tmux list-sessions
```
If the result printed has "fig12a-session", this means the simulation is still in progress. 

## Fetch Result

Using the following command to fetch the results:
```
mkdir -p ~/MLEC-simulator-doc/data/fig12
cp ~/mlec-sim/src/results/slec-local-cp-dur-thru.dat ~/MLEC-simulator-doc/data/fig12a/slec-local-cp-dur-thru.dat
cp ~/mlec-sim/src/results/slec-net-cp-dur-thru.dat ~/MLEC-simulator-doc/data/fig12a/slec-net-cp-dur-thru.dat
cp ~/mlec-sim/src/results/mlec-c-c-dur-thru.dat ~/MLEC-simulator-doc/data/fig12a/mlec-c-c-dur-thru.dat
```

# Generate Plots

Then, we generate the plots based on the simulation result

```
mkdir -p ~/MLEC-simulator-doc/plots/fig12a
cd ~/MLEC-simulator-doc/
python3 scripts/fig12a/plot.py plots/fig12a/fig12a.png
```

You can then check the plots in the directory "~/MLEC-simulator-doc/plots/fig12a".
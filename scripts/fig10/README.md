# Figure 10: Durability

## Introduction
In this simulation, we run the experiments for Figure 10. Since the simulation takes 3-4 hours to run, we run it in the background using "tmux". First, run the following command: 

```
source ~/.bashrc
cd ~/MLEC-simulator-doc/scripts/fig10
tmux new-session -d -s fig10-session 'bash exp.sh &> fig10.log; tmux kill-session -t fig10-session'
```

## Wait Results
Usually, the simulations takes 3-4 hours. You can check the progress via the command:
```
tmux list-sessions
```
If the result printed has "fig10-session", this means the simulation is still in progress. 

## Fetch Result

Using the following command to fetch the results:
```
mkdir ~/MLEC-simulator-doc/data/fig10
cp ~/mlec-sim/src/scheme-0.dat ~/MLEC-simulator-doc/data/fig10/scheme-0.dat
cp ~/mlec-sim/src/scheme-1.dat ~/MLEC-simulator-doc/data/fig10/scheme-1.dat
cp ~/mlec-sim/src/scheme-2.dat ~/MLEC-simulator-doc/data/fig10/scheme-2.dat
cp ~/mlec-sim/src/scheme-3.dat ~/MLEC-simulator-doc/data/fig10/scheme-3.dat
```

# Generate Plots

Then, we generate the plots based on the simulation result

```
mkdir -p ~/MLEC-simulator-doc/plots/fig10
cd ~/MLEC-simulator-doc/
python3 scripts/fig10/plot.py plots/fig10/fig10.png
```

You can then check the plots in the directory "~/MLEC-simulator-doc/plots/fig10".
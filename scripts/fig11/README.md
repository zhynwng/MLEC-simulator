# Figure 11: Encoding throughput heatmap

## Introduction
In this simulation, we measure SLEC encoding throughput for differnet k and p. Since the simulation takes 2-3 hours to run, we run it in the background using "tmux". First, run the following command: 

```
cd ~/ReedSolomonEC
tmux new-session -d -s fig11-session 'python scripts/gen_slec.py; tmux kill-session -t fig11-session'
```

## Wait Results
Usually, the simulations takes 2-3 hours. You can check the progress via the command:
```
tmux list-sessions
```
If the result printed has "fig11-session", this means the simulation is still in progress. 

## Fetch Result

Using the following command to fetch the results:
```
mkdir ~/MLEC-simulator-doc/data/fig11
cp ~/ReedSolomonEC/data/test.csv data/fig11/slec.dat
```

# Generate Plots

Then, we generate the plots based on the simulation result

First, install seaborn so that we can plot the heatmap
```
pip3 install seaborn
```

Then, plot the results using our python script

```
mkdir -p ~/MLEC-simulator-doc/plots/fig11
cd ~/MLEC-simulator-doc/
python3 scripts/fig11/plot.py data/fig11/slec.dat plots/fig11/slec-thru-heatmap.png
```

You can then check the plots in the directory "~/MLEC-simulator-doc/plots/fig11". The figure should have the same pattern as Figure 11 in the paper. The absolute values could be different, because we used a different machine for throughput evaluation  when we wrote the paper. However, the relative values and our findings stay the same.
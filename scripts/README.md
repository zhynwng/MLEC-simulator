## Introduction

Each subfolder in this folder contains scripts to run MLEC simulations under different configurations. You can check out how to use them in their respective folders. Below is a brief summary of each subfolder. 

## Fig 5
The script in this folder computes burst tolerance for different MLEC schemes and repair methods using dynamic programming. It then reproduces Figure 5 based on experiment results. It should take 10 minutes to run.
    
## Fig8
The script in this folder runs simulation in "normal" mode and evaluates the repair network traffic for different MLEC schemes and repair methods. It then plots Figure 8 based on experiment results. It should take 5-10 minutes to run.
    
## Fig10
The script in this folder runs simulation in "splitting" mode to simulate the high durability for different MLEC schemes and repair methods. It then plots Figure 10 based on experiment results. It takes 3-4 hours to finish. Since it takes long time, we run the experiments in the background using "tmux". We also provide a script to help monitor if the experiments have finished or not.
    
## Fig11

The script in this folder measures the encoding throughput for different SLEC configurations and then plot a heatmap (Figure 11) for it. It takes 2-3 hours to finish and we also run it in the background.
    
## Fig12a
The script in this folder evaluates the durability and throughput for different EC schemes. The durability evaluation is done using "splitting" method, which is complicated to configure and time-consuming to run. Therefore, we provide well-prepared scripts to run the experiments, and reproduce 10 data points from Figure 12a. These data points should be representative enough to show the patterns and findings mentioned in the paper. It takes 3-5 hours to finish and we also run it in the background.

## Summary
In summary, the entire artifact takes 8-12 hours to run. But many of then are configured to run in the background using "tmux", which we hope can help save reviewers' time
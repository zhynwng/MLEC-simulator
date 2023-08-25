# MLEC-simulator
## Introduction
This repo is the final deliveries of the OSRE 2023 project, "Reproducible Evaluation of Multi-level Erasure Coding". As proposed in [OSRE 2023](https://ucsc-ospo.github.io/report/osre23/ornl/multilevelerasure/20230801-zhiyanw/), this repo contains the artifacts and guides to reproducibly evaluate MLEC(Multi-level Erasure coding) through the simulator we built. 

Overall, the goal of our project is to build a simulator to reproducibly evaluate the performance and durability of MLEC for large-scale storage systems under different design configurations. In this way, we can reduce the cost to modify the configurations of a real large-scale system to see the effects of different EC policies. And this repo is essentially a guide to properly use the simulator to evaluate MLEC. 


This repo also contains steps to reproduce multiple evaluation figures from the SC23 paper "Design Considerations and Analysis of Multi-Level Erasure Coding in Large-Scale Data Centers", as well as all the sample data and figures. If you follow the steps in each REAME file, you should be able to reproduce those data and figure. 

## Step 0: Reserve node

To properly run the simualtor, it's best to use a node with many CPU cores. Our code uses multiple threads to run the simulator in parallel, and a node with a lot of CPU cores would make simulation much faster.

For example, you may reserve a node from [Chameleon](https://chameleoncloud.readthedocs.io/en/latest/technical/reservations.html). The zen3 compute node has 256 cores, which is suitable for the job. Then, launch the reserved node with the image "CC-Ubuntu20.04", and don't forget to assign a floating IP to it, so you can ssh into it. 

## Step 1: Setup node 

Before running the experiments, we need to download the packages listed in `setup.sh`. First, we clone this repo into your server. 

#### Note: all commands below should be run on your reserved Chameleon node connected through ssh, not your local laptop.

```
rm -rf sc23-mlec
git clone https://github.com/zhynwng/MLEC-simulator
```

Then, we set up and install the simulator
```
cd MLEC-simulator/scripts && bash setup-node.sh
```

This will take around 10 minutes to complete.

## Run the Simulator

Now, you can head to each of the figure files to run the simulator:

    - Fig5.ipynb computes burst tolerance for different MLEC schemes and repair methods using dynamic programming. It then reproduces Figure 5 based on experiment results. It should take 10 minutes to run.
    
    - Fig8.ipynb runs simulation in "normal" mode and evaluates the repair network traffic for different MLEC schemes and repair methods. It then plots Figure 8 based on experiment results. It should take 5-10 minutes to run.
    
    - Fig10.ipynb runs simulation in "splitting" mode to simulate the high durability for different MLEC schemes and repair methods. It then plots Figure 10 based on experiment results. It takes 3-4 hours to finish. Since it takes long time, we run the experiments in the background using "tmux". We also provide a script to help monitor if the experiments have finished or not.
    
    - Fig11.ipynb measures the encoding throughput for different SLEC configurations and then plot a heatmap (Figure 11) for it. It takes 2-3 hours to finish and we also run it in the background.
    
    - Fig12a.ipynb evaluates the durability and throughput for different EC schemes. The durability evaluation is done using "splitting" method, which is complicated to configure and time-consuming to run. Therefore, we provide well-prepared scripts to run the experiments, and reproduce 10 data points from Figure 12a. These data points should be representative enough to show the patterns and findings mentioned in the paper. It takes 3-5 hours to finish and we also run it in the background.

In summary, the entire artifact takes 8-12 hours to run. But many of then are configured to run in the background using "tmux", which we hope can help save reviewers' time
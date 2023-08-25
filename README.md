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
cd
rm -rf MLEC-simulator-doc
git clone https://github.com/zhynwng/MLEC-simulator-doc.git
```

Then, we set up and install the simulator
```
cd MLEC-simulator-doc/scripts && bash setup-node.sh
```

This will take around 10 minutes to complete. Lastly, create folders to contain the output data and figure

```
cd ~/MLEC-simulator-doc
mkdir data
mkdir plots
```

## Run the Simulator

Now, you can go to script folder, which contains the intructions to reproduce multiple evaluation figures. We also included the sample output data and figure we have in /sample_output folder, which you may compare with your own results.
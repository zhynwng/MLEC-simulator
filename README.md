# MLEC-simulator
## Introduction
This repo is the final deliveries of the OSRE 2023 project, "Reproducible Evaluation of Multi-level Erasure Coding". As proposed in [OSRE 2023](https://ucsc-ospo.github.io/report/osre23/ornl/multilevelerasure/20230801-zhiyanw/), this repo contains the artifacts and guides to reproducibly evaluate MLEC(Multi-level Erasure coding) through the simulator we built. 

Overall, the goal of our project is to build a simulator to reproducibly evaluate the performance and durability of MLEC for large-scale storage systems under different design configurations. In this way, we can reduce the cost to modify the configurations of a real large-scale system to see the effects of different EC policies. And this repo is essentially a guide to properly use the simulator to evaluate MLEC. 


This repo also contains steps to reproduce multiple evaluation figures from the SC23 paper "Design Considerations and Analysis of Multi-Level Erasure Coding in Large-Scale Data Centers", as well as all the sample data and figures. If you follow the steps in each REAME file, you should be able to reproduce those data and figure. 

## Step 0: Reserve node

To properly run the simualtor, it's best to use a node with many CPU cores. Our code uses multiple threads to run the simulator in parallel, and a node with a lot of CPU cores would make simulation much faster. For example, you may reserve a node from [Chameleon](https://chameleoncloud.readthedocs.io/en/latest/technical/reservations.html)

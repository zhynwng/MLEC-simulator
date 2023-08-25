# Figure 5: PDL under correlated failures

## Introduction
In this instruction, we compute the burst tolerance for different MLEC schemes that corresponds to figure 5 in the paper. First, run the following command: 

```
source ~/.bashrc 
cd /scripts/fig5
bash exp.sh
```
## Fetch Results
Then we fetch the results from the MLEC simulator to ~/MLEC-simulator-doc/data/fig5

```
mkdir ~/MLEC-simulator-doc/data/fig5
cp ~/mlec-sim/src/theory/s-burst-theory-MLEC_C_C.log ~/MLEC-simulator-doc/data/fig5/
cp ~/mlec-sim/src/theory/s-burst-theory-MLEC_C_D.log ~/MLEC-simulator-doc/data/fig5/
cp ~/mlec-sim/src/theory/s-burst-theory-MLEC_D_C.log ~/MLEC-simulator-doc/data/fig5/
cp ~/mlec-sim/src/theory/s-burst-theory-MLEC_D_D.log ~/MLEC-simulator-doc/data/fig5/
```

# Generate Plots

Then, we generate the plots based on the simulation result
```
mkdir ~/MLEC-simulator-doc/plots/fig5
cd ~/MLEC-simulator-doc/
python3 scripts/fig5/plot-mcd.py data/fig5/s-burst-theory-MLEC_C_D.log plots/fig5/mcd.png
python3 scripts/fig5/plot-mcd.py data/fig5/s-burst-theory-MLEC_C_D.log plots/fig5/mcd.png
python3 scripts/fig5/plot-mdc.py data/fig5/s-burst-theory-MLEC_D_C.log plots/fig5/mdc.png
python3 scripts/fig5/plot-mdd.py data/fig5/s-burst-theory-MLEC_D_D.log plots/fig5/mdd.png
```

You can then check the plots in the directory "~/MLEC-simulator-doc/plots/fig5"
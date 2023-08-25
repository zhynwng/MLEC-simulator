import matplotlib.pyplot as plt
from matplotlib import font_manager
import numpy as np
import pandas as pd
import sys

if len(sys.argv) - 1 < 1:
  print("python plot.py [OUTPUT_PATH]")
  exit(0)

OUTPUT_PATH = sys.argv[1]

fontsize = 29
labelfontsize=27
tickfontsize=25

plt.rcParams["font.size"] = fontsize
plt.rcParams['lines.markersize'] = 11

n_groups = 4
columns = ['type','config','durability', 'throughput']

mlec = pd.read_csv('data/fig12a/mlec-c-c-dur-thru.dat', sep=' ', header=None, names=columns)
slec_local = pd.read_csv('data/fig12a/slec-local-cp-dur-thru.dat', sep=' ', header=None, names=columns)
slec_net = pd.read_csv('data/fig12a/slec-net-cp-dur-thru.dat', sep=' ', header=None, names=columns)




# plt.scatter(mlec['cores'].tolist(), mlec['durability'].tolist(),  color='blue', label='C/C')
# plt.scatter(slec_local['cores'].tolist(), slec_local['durability'].tolist(),  color='red', label='L-C')
# plt.scatter(slec_net['cores'].tolist(), slec_net['durability'].tolist(),  color='orange', label='N-C')

mlec_color = 'green'
local_color = 'darkviolet'
net_color = 'red'
finding_color = 'blue'

mlec_throughput = [i/1000 for i in mlec['throughput'].tolist()]
local_throughput = [i/1000 for i in slec_local['throughput'].tolist()]
net_throughput = [i/1000 for i in slec_net['throughput'].tolist()]

plt.scatter(mlec['durability'].tolist(), mlec_throughput,  color=mlec_color, label='C/C', marker="o", s=85)
plt.scatter(slec_local['durability'].tolist(), local_throughput,  facecolors='none', edgecolors=local_color, label='Loc-Cp-S', marker="o", linewidth=2)
plt.scatter( slec_net['durability'].tolist(), net_throughput, color=net_color, label='Net-Cp-S', marker="x", linewidth=2)


fig = plt.gcf()
ax = plt.gca()

ax.set_xlabel('Durability (nines)')
ax.set_ylabel('Throughput (GB/s)')
ax.set_title('C/C vs SLEC Cp', fontsize=fontsize)

fig.set_size_inches(6.1, 5)
fig.set_dpi(300)

legend = ax.legend(loc=(0.5, 0.63), frameon=True, markerfirst=False, handletextpad=-0.3, labelspacing=0.1, borderpad=0.2)

ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

plt.ylim((0,22))
plt.xlim((0,40))
plt.yticks([0,4,8,12,16, 20], fontsize=tickfontsize)
plt.xticks([0,10,20,30,40], fontsize=tickfontsize)

ax.text(4, 2, 'F#1', color=local_color, fontsize=labelfontsize)
ax.annotate('', xy=(1,15), xytext=(5,3),
            arrowprops=dict(arrowstyle='->', color=local_color))

ax.annotate('', xy=(15,4), xytext=(9.5,2.3),
            arrowprops=dict(arrowstyle='->', color=local_color))

ax.text(33, 4.5, 'F#2', color=mlec_color, fontsize=labelfontsize)
ax.annotate('', xy=(38.5,3.45), xytext=(36,4.5),
            arrowprops=dict(arrowstyle='->', color=mlec_color))
ax.annotate('', xy=(33,3.5), xytext=(35,4.5),
            arrowprops=dict(arrowstyle='->', color=mlec_color))

# ax.text(26, 60, 'L(28+12)', color=local_color, fontsize=labelfontsize)
# ax.text(11, 32, 'N(21+9)', color=net_color, fontsize=labelfontsize)
# ax.text(32, 28, '(17+3)/(17+3)', color=mlec_color, fontsize=labelfontsize)
# ax.text(25, 22, '(10+2)/(17+3)', color=mlec_color, fontsize=labelfontsize)

plt.savefig(OUTPUT_PATH,  bbox_inches='tight')

plt.show()
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

title_font_size = 28
tick_font_size = 22

plt.rcParams["font.size"] = 22
label_font = {'fontsize':'20'}
annotation_font = {'fontname':'Helvetica', 'fontsize':title_font_size}


if len(sys.argv) - 1 < 1:
  print("python plot.py [OUTPUT_PATH]")
  exit(0)

OUTPUT_PATH = sys.argv[1]


n_groups = 4
columns = ['placement','value']
schemes = {}
for i in range(4):
  schemes[i] = pd.read_csv('data/fig8/scheme-{}.dat'.format(i), sep=' ', header=None, names=columns)['value'].tolist()

# create plot
fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True, gridspec_kw={'height_ratios': [2, 9]})
ax1.spines['bottom'].set_visible(False)
ax1.spines['top'].set_visible(False)
ax1.spines['right'].set_visible(False)
ax1.tick_params(axis='x',which='both',bottom=False)
ax2.spines['top'].set_visible(False)
ax2.spines['right'].set_visible(False)
ax2.tick_params(axis='x',which='both',length=0)

ax1.set_ylim(26000,27000)
ax2.set_ylim(0,4500)
ax2.set_xlim(-0.3, 3.8)
ax2.set_xlim(-0.3,3.8)
ax1.set_yticks([27000])
ax2.set_yticks([0,1000,2000,3000,4000])
ax1.tick_params(axis='y', labelsize=17)
ax2.tick_params(axis='y', labelsize=17)

index = np.arange(n_groups)
bar_width = 0.2
opacity = 0.8

colors = ['red', 'orange', 'green', 'blue']
labels = ['R$_{ALL}$', 'R$_{FCO}$', 'R$_{HYB}$', 'R$_{MIN}$']
for i in range(4):
  s_top = ax1.bar(index+i*bar_width, schemes[i], bar_width,
  alpha=opacity,
  color=colors[i],
  label='{}'.format(labels[i]))

  s_bot = ax2.bar(index+i*bar_width, schemes[i], bar_width,
  alpha=opacity,
  color=colors[i]
  )

ax2.set_ylabel('Cross-rack Traffic (TB)', fontsize=21)
ax2.yaxis.set_label_coords(-0.137, 0.65)


xtics = [0.3, 1.3, 2.3, 3.3]
xlabels = ['C/C', 'C/D', 'D/C', 'D/D']

plt.xticks(xtics, xlabels, fontsize=22)

plt.subplots_adjust(hspace=0.1)


axis_break1 = 4500
axis_break2 = 26000
x_min = -0.3
l = 0.05  # "break" line length
kwargs = dict(color="k", clip_on=False, linewidth=1)
ax1.plot((x_min - l, x_min + l), (axis_break2, axis_break2), **kwargs)# top-left
ax2.plot((x_min - l, x_min + l), (axis_break1, axis_break1), **kwargs)# bottom-left

textfontsize = 18
linewidth=1
plt.text(1.33, 100, '3.1', fontsize=textfontsize, color=colors[2])
plt.text(1.53, 100, '0.8', fontsize=textfontsize, color=colors[3])
plt.text(3.33, 100, '3.1', fontsize=textfontsize, color=colors[2])
plt.text(3.53, 100, '0.8', fontsize=textfontsize, color=colors[3])

ax1.text(0.3, 26300, 'F#1', color=colors[0])
ax1.annotate('', xy=(0.85,26200), xytext=(0.56,26450),
            arrowprops=dict(arrowstyle='->', color=colors[0]))
ax1.annotate('', xy=(0.12,26000), xytext=(0.27,26450),
            arrowprops=dict(arrowstyle='->', color=colors[0]))

ax1.text(1.23, 26000, 'F#2', color=colors[1])
ax1.annotate('', xy=(1.08,26150), xytext=(1.25,26150),
            arrowprops=dict(arrowstyle='->', color=colors[1]))
ax2.annotate('', xy=(1.29,1000), xytext=(1.29,4500),
            arrowprops=dict(arrowstyle='->', color=colors[1]))


ax2.text(2.4, 2000, 'F#4', color=colors[3])
ax2.annotate('', xy=(2.38,900), xytext=(2.48,1900),
            arrowprops=dict(arrowstyle='->', color=colors[3]))
ax2.annotate('', xy=(2.61,200), xytext=(2.53,1900),
            arrowprops=dict(arrowstyle='->', color=colors[3]))

ax2.text(3.25, 2000, 'F#3', color=colors[2])
ax2.annotate('', xy=(3.24,900), xytext=(3.35,1900),
            arrowprops=dict(arrowstyle='->', color=colors[2]))
ax2.annotate('', xy=(3.40,350), xytext=(3.40,1900),
            arrowprops=dict(arrowstyle='->', color=colors[2]))


ax1.legend(loc=(0.01, 0.95), ncol=4, frameon=False, markerfirst=False, fontsize=22)

fig.set_size_inches(11, 3)
fig.set_dpi(300)

plt.savefig(OUTPUT_PATH,  bbox_inches='tight')
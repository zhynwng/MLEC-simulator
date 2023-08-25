import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

title_font_size = 28
tick_font_size = 22
textfontsize = 11
textfontcolor = 'purple'
anotation_color = textfontcolor

plt.rcParams["font.size"] = 24
label_font = { 'fontsize':'20'}
annotation_font = {'fontsize':title_font_size}


if len(sys.argv) - 1 < 1:
    print("python plot.py [INPUT_PATH] [OUTPUT_PATH]")
    exit(0)
    
OUTPUT_PATH = sys.argv[1]


n_groups = 4
columns = ['placement', 'durability']
schemes = {}
for i in range(4):
  schemes[i] = pd.read_csv('data/fig10/scheme-{}.dat'.format(i), sep=' ', header=None, names=columns)['durability'].tolist()

# create plot
fig, (ax) = plt.subplots(1, 1, sharex=True)
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.tick_params(axis='x',which='both',length=0)

# ax1.set_ylim(0,40)
ax.set_ylim(0,40)
ax.set_xlim(-0.3,3.8)
ax.set_yticks([0,10,20,30,40])
ax.tick_params(axis='y', labelsize=20)


index = np.arange(n_groups)
bar_width = 0.2
opacity = 1

colors = ['red', 'orange', 'green', 'blue']
labels = ['R$_{ALL}$', 'R$_{FCO}$', 'R$_{HYB}$', 'R$_{MIN}$']

  

for i in range(4):

  s_bot = ax.bar(index+i*bar_width, schemes[i], bar_width,
  alpha=opacity,
  color=colors[i],
  # edgecolor=colors[i],
  label='{}'.format(labels[i])
  )

ax.set_ylabel('Durability (nines)')
ax.yaxis.set_label_coords(-0.06,0.5)


xtics = [0.3, 1.3, 2.3, 3.3]
xlabels = ['C/C', 'C/D', 'D/C', 'D/D']

plt.xticks(xtics, xlabels)

plt.subplots_adjust(hspace=0.1)


axis_break1 = 800
axis_break2 = 2600
x_min = -0.3
l = 0.05  # "break" line length
kwargs = dict(color="k", clip_on=False, linewidth=1)
# ax1.plot((x_min - l, x_min + l), (axis_break2, axis_break2), **kwargs)# top-left
# ax.plot((x_min - l, x_min + l), (axis_break1, axis_break1), **kwargs)# bottom-left


ax.text(2.75, 30, 'F#1', color=colors[1])
ax.annotate('', xy=(3.1,28), xytext=(2.88,29.5),arrowprops=dict(arrowstyle='-', color=colors[1]))
ax.annotate('', xy=(3.0,25), xytext=(2.88,29.5),arrowprops=dict(arrowstyle='-', color=colors[1]))


ax.text(0.95, 33, 'F#2', color=colors[2])
ax.annotate('', xy=(1.3,31), xytext=(1.08,32.5),arrowprops=dict(arrowstyle='-', color=colors[2]))
ax.annotate('', xy=(1.2,28.5), xytext=(1.08,32.5),arrowprops=dict(arrowstyle='-', color=colors[2]))

ax.text(0.15, 31, 'F#3', color=colors[3])
ax.annotate('', xy=(0.5,28), xytext=(0.28,30.5),arrowprops=dict(arrowstyle='-', color=colors[3]))
ax.annotate('', xy=(0.4,27), xytext=(0.28,30.5),arrowprops=dict(arrowstyle='-', color=colors[3]))

ax.text(2.15, 36, 'F#4', color=colors[3])
ax.annotate('', xy=(1.6,33), xytext=(2.15,37),arrowprops=dict(arrowstyle='-', color=colors[3]))
ax.annotate('', xy=(3.6,32), xytext=(2.44,37),arrowprops=dict(arrowstyle='-', color=colors[3]))



# ax.text(1.3, 400, 'F#2', color=colors[2])
# ax.annotate('', xy=(1.2,100), xytext=(1.37,350),
#             arrowprops=dict(arrowstyle='->', color=colors[2]))
# ax.annotate('', xy=(1.4,90), xytext=(1.4,350),
#             arrowprops=dict(arrowstyle='->', color=colors[2]))

# ax.text(2.22, 450, 'F#3', color=colors[3])
# ax.annotate('', xy=(2.4,25), xytext=(2.34,400),
#             arrowprops=dict(arrowstyle='->', color=colors[3]))
# ax.annotate('', xy=(2.5,100), xytext=(2.36,400),
#             arrowprops=dict(arrowstyle='->', color=colors[3]))

# linewidth=1
# plt.text(1.32, 150, '0.3', fontsize=textfontsize, color=textfontcolor)
# plt.arrow(1.4,140,0.0,-130, head_width=0.05, head_length=20, color=anotation_color,length_includes_head=True, joinstyle='miter')
# # plt.arrow(1.3,140,0.1,-130,head_width=1, head_length=2, linewidth=linewidth, color=anotation_color,length_includes_head=True, joinstyle='miter')

# plt.text(1.54, 150, '0.08', fontsize=textfontsize, color=textfontcolor)
# plt.arrow(1.6,140,0.0,-130, head_width=0.05, head_length=20, color=anotation_color,length_includes_head=True, joinstyle='miter')

# plt.text(3.32, 150, '0.1', fontsize=textfontsize, color=textfontcolor)
# plt.arrow(3.4,140,0.0,-130, head_width=0.05, head_length=20, color=anotation_color,length_includes_head=True, joinstyle='miter')

# plt.text(3.54, 150, '0.02', fontsize=textfontsize, color=textfontcolor)
# plt.arrow(3.6,140,0.0,-130, head_width=0.05, head_length=20, color=anotation_color,length_includes_head=True, joinstyle='miter')

ax.legend(loc=(0.01, 0.98), ncol=4, frameon=False, markerfirst=False)
# ax.legend(loc=(0.01, 0.97), ncol=4, frameon=False, markerfirst=False)

fig.set_size_inches(11, 3)
fig.set_dpi(300)

plt.savefig(OUTPUT_PATH,  bbox_inches='tight')
from matplotlib.colors import LinearSegmentedColormap
import matplotlib.pylab as plt
import os
import numpy as np
import seaborn as sns
import sys

MAX_N = 50
MAX_K = 10


if len(sys.argv) - 1 < 2:
    print("python plot.py [INPUT_PATH] [OUTPUT_PATH]")
    exit(0)
    
INPUT_PATH = sys.argv[1]
OUTPUT_PATH = sys.argv[2]

fontsize = 27
tickfontsize=25
plt.rcParams["font.size"] = fontsize

throughput_target = 600/8

def GetLines():
    """
    Fetches the lines in the output file.
    """
    file_exists = os.path.exists(INPUT_PATH)
    if file_exists:
        with open(INPUT_PATH, "r") as f:
            lines = f.readlines()
            return lines

def ReadData():
    """
    Creates heatmap array with throughput data.
    """

    # Create empty array that can be populated with data.
    array = [[np.nan for n in range(MAX_N + 1)] for k in range(MAX_K + 1)]

    lines = GetLines()
    for line in lines[1:]:
        n, k, throughput = line.split(",")
        n = int(n)
        k = int(k)
        if (n <= MAX_N) and (k <= MAX_K) and n > 1:
            throughput, _ = throughput.split("\n")
            # Populate array with throughput data.
            throughput = float(throughput) / 1000
            array[k][n] = throughput

    return array


def GenerateHeatmap(data):
    """
    Generates a heatmap given an array of data.
    """

    array = np.array(data, dtype=float)

    # Define custom colormap
    colorlist = ['black', 'maroon', 'red', '#FF4000', '#FF8000', '#FFC000', 'yellow', '#E6FF00', '#B3FF00', 'lime', '#00D100', '#009500', 'darkgreen']
    # colorlist.reverse()
    n_colors = 256  # number of colors in the colormap
    cmap = LinearSegmentedColormap.from_list("Custom", colorlist, N=n_colors)

    # Generate heatmap
    mask = np.isnan(array)
    plt.figure(figsize=(16, 6))
    ticks = [0, 5, 10,15,20]
    vmax = 20
    vmin = 0
    cbar_kws = {"label": "Throughput (GB/s)", "drawedges": False, "shrink": 0.5, "spacing": "proportional", "ticks": ticks}
    ax = sns.heatmap(array, cmap=cmap, mask=mask, linewidths=0.5, cbar_kws=cbar_kws, square=True, vmax=vmax, vmin=vmin)
    cbar = ax.collections[0].colorbar
    cbar.ax.tick_params(labelsize=tickfontsize)

    ax.set_facecolor('lightgray')

    # X-Y axis labels
    ax.set_ylabel("Parity chunks p")
    ax.set_xlabel("Data chunks k")
    ax.invert_yaxis()

    # Set axis label settings
    x_tick_positions = np.arange(0, len(data[0]), 10)
    x_tick_labels = [str(x) for x in x_tick_positions]
    real_x_tick_positions = [x+0.5 for x in x_tick_positions]
    ax.set_xticks(real_x_tick_positions)
    ax.set_xticklabels(x_tick_labels, fontsize=tickfontsize, rotation=0)

    y_tick_positions = np.arange(0, len(data), 5)
    y_tick_labels = [str(y) for y in y_tick_positions]
    real_y_tick_positions = [y+0.5 for y in y_tick_positions]
    ax.set_yticks(real_y_tick_positions)
    ax.set_yticklabels(y_tick_labels, fontsize=tickfontsize, rotation=0)

    ax.grid(False)

    # Set title
    ax.set_title("Single-core encoding throughput for (k+p) SLEC", y=1.08, fontsize=fontsize)

    # Set boundary around outside of heatmap
    for _, spine in ax.spines.items():
        spine.set_visible(True)
        spine.set_edgecolor('black')
        spine.set_linewidth(0.5)

    # Save and show heatmap.
    plt.savefig(OUTPUT_PATH,  bbox_inches="tight")
    plt.show()


def main():
    array = ReadData()
    GenerateHeatmap(array)


if __name__ == "__main__":
    main()
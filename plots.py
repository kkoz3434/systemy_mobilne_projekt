import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read the CSV file
file_path = 'all_data.csv'
data = pd.read_csv(file_path, delimiter=';')

data.loc[data['app'] == 'animation', 'time'] -= 5000

def resource2label(resource):
    if resource == 'time':
        return 'time [ms]'
    if resource == 'cpu':
        return 'CPU usage [%]'
    if resource == 'ram':
        return 'RAM usage [MB]'
    raise Exception("Wrong resource name")

def plot_data(data, app, resource):
    assert app in ['gps', 'calculations', 'animation', 'video']
    assert resource in ['time', 'cpu', 'ram']

    # Filter the data by app, group by (framework, platform) and take specific resource column
    measures = data[data['app'] == app].groupby(['framework', 'platform'])[resource]
    agg_measures = measures.agg(['mean', 'std'])

    # Setup bars
    bar_width = 0.2
    index = np.arange(len(agg_measures))
    colors = plt.cm.viridis(np.linspace(0, 1, len(agg_measures)))
    error_kw = {'capsize': 5, 'capthick': 2, 'ecolor': 'black'}

    # Create a bar graph
    fig, ax = plt.subplots()
    for idx, (mean, std) in enumerate(zip(agg_measures['mean'], agg_measures['std'])):
        ax.bar(index[idx], mean, bar_width, yerr=std, color=colors[idx], label=f'{agg_measures.index[idx]}', error_kw=error_kw)

    # Labeling
    ax.set_xlabel('Technology')
    ax.set_ylabel(f'Average {resource2label(resource)}')
    ax.set_title(f'Avg {resource2label(resource)} with stdev for {app} app by Technology')
    ax.set_xticks(index)
    ax.set_xticklabels([f"{a}, {b}" for a, b in agg_measures.index], rotation=45, ha='right')
    ax.legend()

    plt.tight_layout()
    plt.show()


for res in ['time', 'ram', 'cpu']:
    for app in ['gps', 'animation', 'video', 'calculations']:
        plot_data(data, app, res)

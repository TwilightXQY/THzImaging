import pandas as pd
file='dicts.csv'
df = pd.read_csv(file)
df.values
data = df.values
data = list(map(list, zip(*data)))
data = pd.DataFrame(data)
data.to_csv('' + file, header=0, index=0)

csv_file = "dicts.csv"
csv_data = pd.read_csv(csv_file, header = None, low_memory = False)#防止弹出警告
csv_df = pd.DataFrame(csv_data)
csv_df = df.apply(lambda x: x.str.strip('[]'))
print(csv_df)
csv_df.to_csv('output.csv')

import pandas as pd
import csv

# 读入原始数据
raw = pd.read_csv('raw.csv', delimiter = '\t', header = None)
raw = raw.values.tolist()

# 进行格式调整
csvFile = open('medium.csv', "w+", newline='')
try:
    writer = csv.writer(csvFile)
    for i in range(len(raw)):
        writer.writerow(raw[i])
finally:
    csvFile.close()

# 读入调整后数据
cooked = pd.read_csv('medium.csv', header = None)
array = cooked.T.to_numpy()

# 对CSV进行数据处理
tag = 0
dist_data = {}
for i in range (0, len(cooked.columns), 84):
    if array[i] == '!T':
        current_gain = array[i + 3]
        mag = array[i + 6]
        distance = array[i + 5]
        for j in range (6, 84, 5):
            if array[j + (tag * 84)] > mag:
                distance = array[j + (tag * 84) - 1]
                mag = array[j + (tag * 84)]
    dist_data[i / 84] = distance
    tag = tag + 1

# 将距离信息写入final.csv
header = list(dist_data.keys()) 
with open('final.csv', 'a', newline = '', encoding = 'utf-8') as f:
    writer = csv.DictWriter(f, fieldnames = header)
    writer.writeheader()

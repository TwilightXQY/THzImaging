# 太赫兹成像流程
1. 用DataCollect.m进行数据采集，采集后生成raw.csv
2. 用process.py进行数据处理，处理后生成medium.csv，随后对数据进行筛选，筛选后生成final.csv，包含每个时间戳上物体的距离、幅度和相位信息

  
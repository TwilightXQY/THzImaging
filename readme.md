# 太赫兹成像流程
1.  用DataCollect.m进行数据采集，采集后生成raw.csv
2.  用process.py进行数据处理，生成final.csv，包含每个时间戳上物体的距离、幅度和相位信息
3.  用excel打开final.csv，对(1,1)单元格进行修改
4.  进行后续成像内容

  
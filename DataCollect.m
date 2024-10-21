clear;
close all;
clc;

% 雷达串口设置
serialPort_string = 'COM3';
baudrate = 230400;
comPort = serialport(serialPort_string, baudrate, 'Timeout', 1);
serialPort = comPort;
configureTerminator(serialPort, 'CR/LF');
flush(serialPort);
pause(0.1);

% 写雷达设置标志字
SYS_CONFIG = '!S00032F82';
RFE_CONFIG = '!F00075300';
PLL_CONFIG = '!P00000BB8';
BBS_CONFIG = '!BE422E674';
WriteBuffer(SYS_CONFIG, RFE_CONFIG, PLL_CONFIG, BBS_CONFIG, serialPort); 

% 创建一个csv文件
rawdata = fopen('raw.csv', 'w+');   

% 接收数据并存入新建的csv文件
flag = 0;
while (flag == 0)
    while (1)
        str = readline(serialPort);
        if (strfind(str, "T") == 2)         % 接收到目标数据
            break;
        end
    end
    fprintf(rawdata, "%s", str);
    if (i == 0)  % 判断条件仍需更改
        flag = 1;
    end
end

% 数据采集结束后关闭csv文件
% fclose(rawdata); 

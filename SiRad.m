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

% 电机串口设置
motor_serial = 'COM7';
baudrate_motor = 19200;
motorCom = serialport(motor_serial, baudrate_motor, 'Timeout', 1);
motorPort = motorCom;
configureTerminator(motorPort, 'CR/LF');
flush(motorPort);
pause(0.1);


% 写雷达设置标志字
SYS_CONFIG = '!S00032F82';
RFE_CONFIG = '!F00075300';
PLL_CONFIG = '!P00000BB8';
BBS_CONFIG = '!BE422E674';
WriteBuffer(SYS_CONFIG, RFE_CONFIG, PLL_CONFIG, BBS_CONFIG, serialPort); 

% 电机系统相关命令
X_Axis_Zero = 'HX↓';    % X轴归零
X_Axis_Stop = 'SPX↓ ';  % X轴停止
X_Axis_SetSpeed = 'VX,top_speed↓'; % X轴设置速度
X_AXis_InitialSpeed = 'FX,init_speed↓'; % X轴初速度
Y_Axis_Zero = 'HY↓';    % Y轴归零
Y_Axis_Stop = 'SPY↓ ';  % X轴停止
Y_Axis_SetSpeed = 'VY,top_speed↓'; % X轴设置速度
Y_AXis_InitialSpeed = 'FY,init_speed↓'; % X轴初速度

% 创建一个csv文件
rawdata = fopen('raw.csv', 'w+');   

% 接受数据并存入新建的csv文件
while (1)

    while (1)
        str = readline(serialPort);
        if (strfind(str, "T") == 2)  % 接收到目标数据
            flag = 1;
            break;
        end
    end
    fprintf(rawdata, "%s", str);
    motor_config = readline(motorPort);
    if (strfind(motor_config, "Y") == 2)  % 电机Y轴发生变化，数据产生变化
        break;
    end
end

% 数据采集结束后关闭csv文件
% fclose(rawdata); 

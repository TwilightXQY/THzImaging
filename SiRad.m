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
X_Axis_Zero = 'HX↓';                    % X轴归零
X_Axis_Stop = 'SPX↓ ';                  % X轴停止
X_Axis_SetSpeed = 'VX,top_speed↓';      % X轴设置速度
X_AXis_InitialSpeed = 'FX,init_speed↓'; % X轴初速度
X_Axis_Move = '+X,1↓';                  % X轴运动一个单位

Y_Axis_Zero = 'HY↓';                    % Y轴归零
Y_Axis_Stop = 'SPY↓ ';                  % Y轴停止
Y_Axis_SetSpeed = 'VY,top_speed↓';      % Y轴设置速度
Y_AXis_InitialSpeed = 'FY,init_speed↓'; % Y轴初速度
Y_Axis_Move = '+Y,1↓';                  % Y轴运动一个单位

% 创建一个csv文件
rawdata = fopen('raw.csv', 'w+');   

% 将电机归零
WriteMotor(X_Axis_Zero, motorPort);
WriteMotor(Y_Axis_Zero, motorPort);

% 吸波材料验证：对吸波材料测距，若距离为0直接换行
% 接收数据并存入新建的csv文件
while (1)
    while (1)
        str = readline(serialPort);
        if (strfind(str, "T") == 2)         % 接收到目标数据
            flag = 1;
            WriteMotor(X_Axis_Move);        % X轴运行到下一个目标点
            break;
        end
    end
    fprintf(rawdata, "%s", str);
    motor_config = readline(motorPort);
    if (strfind(motor_config, "Y") == 2)    % 电机Y轴发生变化，数据产生变化
        break;
    end
end

% 数据采集结束后关闭csv文件
% fclose(rawdata); 

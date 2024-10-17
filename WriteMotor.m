function [] = WriteMotor(command, port)
    config = command;
    
    writeline(port, config);
    flush(port);
    
    pause(0.5);
    end
function [] = WriteBuffer(sys, rfe, pll, bb, port)
sys_config = sys;
rfe_config = rfe;
pll_config = pll;
bbs_config = bb;

writeline(port, sys_config);
flush(port);

writeline(port, rfe_config);
flush(port);

writeline(port, pll_config);
flush(port);

writeline(port, bbs_config);
flush(port);

pause(0.5);
end
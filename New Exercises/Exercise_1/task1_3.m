clear all
close all
clc;
% b) Making rectangular signal

t1 = -3:0.01:4;   % time range
x = 3*rectangularPulse(-1, 2, t1);
% x = 3*(t >= -1 & t <= 2);   % rectangular signal

subplot(3,2,5)
plot(t1, x, 'LineWidth', 2);
xlabel('Time (t)');
ylabel('Amplitude');
title('Rectangular Signal x(t)');
ylim([-0.5 3.5]);  
grid on

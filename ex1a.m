close all;
clc;
clear all;
% ----------------------------------
% STEP 1: Generating the sine wave  
% ----------------------------------

f1 = 4;
N  = 300; % Number of Samples; Number of pints in analog signal
Fs = 30; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/30 = 0.033 sec
t = (0:N/2-1)/Fs; % Time axis from 0 sec to 4.97  sec
a = 3;
y = a*sin(2*pi*f1*t); % generates the sine wave

%subplot (2,1,1);
plot(t, y, 'g');
title("Sine wave");
xlabel("Time, [s]");
ylabel("Amplitude");

ylim([-4 4]), xlim([0 5])
%subplot (2,1,2);
%plot(t, y, 'r');
%title("Sine wave");
%xlabel("Time, [s]");
%ylabel("Amplitude");
%grid;
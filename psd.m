clc;
clear all;
close all;

f1 = 20;
f2 = 10;
N  = 2000; % Number of Samples
Fs = 1000; % sampling frequency
t = ((-N/2):(N/2)-1)/Fs; % start from -1
y = sin(2*pi*f1*t) + 0.5 *sin(2*pi*f2*t); % sinosoidal wave
figure('Name','Sinosoidal wave');
subplot(2,1,1);
plot(t,y);
title('Sampling Frequency 1000 hz'), xlim([-1 1]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;

%% Calculating power spectral density using Wiener Khintchine Theorem (Finding the PSD using ACF)
[r1,lags1] = xcorr(y,'biased');
tau1 = lags1/Fs;

% Taking fourier transform of acf will result in PSD.
Rxxdft1 = abs(fftshift(fft(r1)))/N; % divind by N to normalize

% interval = 1000/3999 = 0.2500
% -500 + interval and so on
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis or normalization of frequency axis, to have  a good plot
subplot(2,1,2);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;
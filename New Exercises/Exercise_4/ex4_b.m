clc;
clear all;
close all;
f1 = 8;
Fs = 100; % Sampling Frequency in Hz 
buffer_length = 4096;
t = (0:1:buffer_length-1)*1/Fs; % Time axis from 0
y = 1*sin(2*pi*f1*t) + 0.05.*(randn(size(t))); % sine wave

figure('Name','PSD in Linear scale');
subplot(3,1,1);
plot(t,y);
title('Sampling Frequency 100 hz')
grid on;

% Calculation of autocorrelation functionusing hamming and rect window
[r1,lags1] = xcorr(y.*rectwin(buffer_length)', 'biased');
[r2, lags2] = xcorr(y .* hamming(buffer_length)', 'biased');

% Calculation PSD using Wiener-Khintchine theorem
% Taking fourier transform of acf will result in PSD.
Rxxdft1 = abs(fftshift(fft(r1)))/buffer_length;
Rxxdft2 = abs(fftshift(fft(r2)))/buffer_length;

freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis or normalization of frequency axis, to have  a good plot
freq2 = -Fs/2:Fs/length(r2):Fs/2-(Fs/length(r2)); % normalized x axis or normalization of frequency axis, to have  a good plot

% Plotting PSD in linear scale
subplot(3, 1, 2);
plot(freq1, Rxxdft1);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density');
title('Rectangular Window - Linear Scale');

subplot(3, 1, 3);
plot(freq2, Rxxdft2);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density');
title('Hamming Window - Linear Scale');

% Plotting PSD in logarithmic scale
figure('Name','PSD in logarithmic scale');
subplot(3,1,1);
plot(t,y);
title('Sampling Frequency 100 hz')
grid on;

subplot(3, 1, 2);
plot(freq1, 10*log10(Rxxdft1));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('Rectangular Window - Logarithmic Scale');

subplot(3, 1, 3);
plot(freq2, 10*log10(Rxxdft2));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('Hamming Window - Logarithmic Scale');



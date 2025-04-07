clear all
close all
clc;

%Signal Frequencies
f = 300;

%Sampling Frequency
fs = 3000;
% fs = 450;
% fs = 900;

%Signals axis Calculation
startP = 0;
endP = 0.02;

% buffer_length = 2048;
buffer_length = 8192;

t = (0:1:buffer_length-1)/fs;
% %Different Approach 1
% t = startP:1/fs:endP;
% N = length(t);

%Noise Amplitudes
% alpha = 0.1;
alpha = 0.3;
% alpha = 2.0;

%Generation of noise and then the signal
% noise = alpha * randn(1, length(t));
noise = alpha * (rand(size(t)) - 0.5);

signal = sin(2*pi*f*t) + sin(3*pi*f*t);
signal_with_noise = signal + noise;

%Calculation of PSD using the Wiener-Khintchine theorem
[signal_corr, lag] = xcorr(signal_with_noise, 'biased');
PSD = abs(fftshift(fft(signal_corr))) / buffer_length;
len = length(lag);
positiveFreq = (-fs/2):(fs/length(lag)):(fs/2 - fs/length(lag)); 


% Plot time signal
figure;
subplot(3,1,1);
plot(t, signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Time Signal');
xlim([startP, endP]);

subplot(3,1,2);
plot(t, signal_with_noise);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Time Signal with noise');
xlim([startP, endP]);

% Plot PSD
subplot(3,1,3);
% plot(freq, PSD);
plot(positiveFreq, PSD);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density');
title('Power Spectral Density (PSD)');
xlim([0, fs/2]);

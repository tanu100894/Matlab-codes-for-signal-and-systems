                                                                                                                                                clear all
close all
clc;

f = 8;             % Frequency (Hz)
alpha = 0.05;      % Amplitude of noise
fs = 100;          % Sampling frequency (Hz)
buffer_length = 4096;

% Time vector
t = (0:1:buffer_length-1)/fs;

% Random noise
noise = alpha * randn(size(t));

% Random process
signal = sin(2*pi*f*t) + noise;

% Calculate autocorrelation function
[acf_rect,acf_rect_lags] = xcorr(signal.*rectwin(buffer_length)', 'biased');
[acf_hamming, acf_hamming_lags] = xcorr(signal .* hamming(buffer_length)', 'biased');

% Calculate PSD using Wiener-Khintchine theorem
psd_rect = abs(fftshift(fft(acf_rect))) / buffer_length;
psd_hamming = abs(fftshift(fft(acf_hamming))) /buffer_length;

N1 = length(psd_rect);
N2 = length(psd_hamming);

% Frequency axis
f_axis_rect = (-fs/2 : fs/N1 : fs/2 - fs/N1);
f_axis_hamm = (-fs/2 : fs/N2 : fs/2 - fs/N2);

% Plot PSD with linear scale
figure;
subplot(3,1,1);
plot(t, signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Time Signal');

subplot(3, 1, 2);
plot(f_axis_rect, psd_rect);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density');
title('Rectangular Window - Linear Scale');

subplot(3, 1, 3);
plot(f_axis_hamm, psd_hamming);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density');
title('Hamming Window - Linear Scale');

% Plot PSD with logarithmic scale
figure;
subplot(3, 1, 1);
plot(f_axis_rect, 10*log10(psd_rect));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('Rectangular Window - Logarithmic Scale');

subplot(3, 1, 2);
plot(f_axis_hamm, 10*log10(psd_hamming));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('Hamming Window - Logarithmic Scale');
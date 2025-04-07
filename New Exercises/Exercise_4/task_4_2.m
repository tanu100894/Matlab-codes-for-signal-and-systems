clear all
close all
clc;

f = 8;   % Frequency (Hz)
alpha = 0.05;   % Alpha value
Fs = 1000;   % Sampling frequency (Hz)
T = 1/Fs;   % Time period

% Time vector
t = 0:T:5;

% Random noise
noise = randn(size(t));

% Random process
signal = sin(2*pi*f*t) + alpha*noise;

% Autocorrelation function calculation
ACF = xcorr(signal, 'biased');  % Use 'biased' to normalize the ACF

% Power spectral density calculation
PSD = abs(fftshift(fft(ACF)));

% Frequency vector
N = length(PSD);
freq = (-Fs/2):(Fs/N):(Fs/2 - Fs/N);

% Plotting
figure;
subplot(3,1,1);
plot(t, signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Time Signal');


subplot(3,1,2);
plot(freq, PSD)
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('Power Spectral Density of Random Process')
xlim([-10, 10]);

subplot(3, 1, 3);
plot(freq, 10*log10(PSD));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('Power Spectral Density in Logarithmic Scale');
xlim([-10, 10]);
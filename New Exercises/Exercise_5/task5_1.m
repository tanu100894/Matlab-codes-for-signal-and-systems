clear all
close all
clc;

% Set the current working directory
% cd('F:/Stochastic Lab takings/Class4/'); % Replace 'path_to_file' with the actual path to the directory

% Read data from the CSV file
data = readmatrix('testsignal_class.csv'); % Replace 'data.csv' with the actual filename

% Access specific columns or rows
signal = data(1, :); 
N = length(signal);
fs = 1000;

t = 0:N-1;

%Plot the signal
figure;
subplot(3,1,1);
plot(t, signal)
xlabel('Time(s)');
ylabel('Amplitude');
title('Given Signal');

%To know base frequencies of an unknown signal find the PSD
ACF = xcorr(signal, 'biased');
PSD = abs(fftshift(fft(ACF)))/N;
NFFT = 2^nextpow2(N);   %Next power of 2 from signal length

%Let's just guess what will be the frequency range
rangeOfPSD = length(PSD);
freq = (-fs/2):(fs/rangeOfPSD):(fs/2 - fs/rangeOfPSD);

subplot(3,1,2);
plot(freq, PSD)
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('Power Spectral Density of Random Process')
xlim([0, 100]);

% Generate random phase angles
rng('default');                     % Set random seed
rand_phase = 2*pi*rand(size(PSD));   % Random phase angles

% Synthesize signal based on PSD
synth_spectrum = sqrt(PSD) .* exp(1i*rand_phase);
synth_signal = ifft(synth_spectrum, NFFT)*N;

% Trim the synthesized signal to match the original signal length
synth_signal = synth_signal(1:N);

%Plot the synthesized signal
subplot(3,1,3);
plot(t, real(synth_signal));
title('Synthesized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-20, 20])
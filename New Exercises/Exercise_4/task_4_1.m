    clear all
close all
clc;

% Set the current working directory
% cd('F:/Stochastic Lab takings/Class4/'); % Replace 'path_to_file' with the actual path to the directory

% Read data from the CSV file
data = readmatrix('C:\Study\Semester2\SSS\New Exercises\Exercise_4\testsignal.csv'); % Replace 'data.csv' with the actual filename

% Access specific columns or rows
signal = data(1, :); 
N = length(signal);
fs = 1000;

t = -N/2:N/2-1;

%Plot the signal
figure;
subplot(3,1,1);
plot(t, signal)
xlabel('Time(s)');
ylabel('Amplitude');
title('Given Signal');

%Let's find the maximum and minimum amplitude of the signal
max_value = max(signal);
min_value = min(signal);
disp(['Maximum value: ' num2str(max_value)]);
disp(['Minimum value: ' num2str(min_value)]);

%To know base frequencies of an unknown signal find the PSD
ACF = xcorr(signal, 'biased');
PSD = abs(fftshift(fft(ACF))) / N;

%Let's just guess what will be the frequency range
rangeOfPSD = length(PSD);
freq = (-fs/2):(fs/rangeOfPSD):(fs/2 - fs/rangeOfPSD);

subplot(3,1,2);
plot(freq, PSD)
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('Power Spectral Density of Random Process')
xlim([0, 100]);

subplot(3, 1, 3);
plot(freq, 10*log10(PSD));
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB)');
title('PSD in Logarithmic Scale');
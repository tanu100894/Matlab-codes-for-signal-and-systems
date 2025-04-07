clear all;
close all;
clc;
data = readmatrix('C:\Users\aggar\Downloads\testsignal.csv'); % Replace 'data.csv' with the actual filename

% Access specific columns or rows
signal = data(1, :); 
N = length(signal);
fs = 1000;

t = -N/2:N/2-1;

%To make the figure bigger and clear
figure1 = figure('Position', [30, 100 ,1500, 600]);

%Plot the signal
subplot(4,1,1);
plot(t, signal)
xlabel('Time(s)');
ylabel('Amplitude');
title('Given Signal');

%To find the minimum and maximum amplitude of the signal
max_value = max(signal);
min_value = min(signal);
disp(['Maximum value: ' num2str(max_value)]);
disp(['Minimum value: ' num2str(min_value)]);

%To find the PSD by using the ACF. So first find out the ACF by using Auto
%correlation function
ACF = xcorr(signal, 'biased');
PSD = abs(fftshift(fft(ACF, 2^nextpow2(N))))/N;

%Let's just guess what will be the frequency range
rangeOfPSD = length(PSD);
freq = (-fs/2):(fs/rangeOfPSD):(fs/2 - fs/rangeOfPSD);

subplot(4,1,2);
plot(freq, PSD)
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('Power Spectral Density of Random Process')
xlim([-100, 100]);


subplot(4, 1, 3);
plot(freq, 10*log10(PSD));
ylabel('Power Spectral Density (dB)');
xlabel('Frequency (Hz)');
title('PSD in Logarithmic Scale');

% Synthesize the signal based on the PSD
synthesized_signal = ifft(sqrt(PSD) .* exp(1i*angle(fftshift(fft(ifftshift(signal), 2^nextpow2(N))))));

% Plotting the Synthesized Signal
subplot(4, 1, 4);
plot(t, real(synthesized_signal));
ylabel('Amplitude');
xlabel('Time (s)');
title('Synthesized Signal');
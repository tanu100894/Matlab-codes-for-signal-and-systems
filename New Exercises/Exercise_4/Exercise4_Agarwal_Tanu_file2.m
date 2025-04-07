% Exercise 4.1

close all;
clear all;
clc;

% Read data from the csv file
data = readmatrix('C:\Users\aggar\Downloads\testsignal.csv');

Fs = 1000; % Sampling frequency
Ts = 1/Fs; % Sampling Period

N = length(data);   % Number of Sampling points
N1 = 2*N;           % Number of discrete points in FFT

t = (0:N-1)/Fs;

%figure1 = figure('Position', [200, 200, 2000, 2000]);
figure1 = figure('Position', [30, 100 ,1500, 600]);
 
% Plot the signal 
subplot(3,1,1);
plot(t,data);
xlabel('time(s)');
ylabel('Amplitude');
title('Sampled Signal');

[auto_cor, lags] = xcorr(data); % Calculate ACF of data
size_of_ACF = length(auto_cor);
tau = lags/Fs;
subplot(3,1,2);
plot(tau,auto_cor);
xlabel('Time lags(s)');
ylabel('Amplitude');
title('ACF of the Sampled Signal');

data_fft = fft(auto_cor);
data_fft = data_fft(1:N1/2);   % Take positive frequencies only
data_psd = (1/(Fs*N1))  * abs(data_fft).^2; % Calculate PSD 
data_psd(2:end-1) = 2*data_psd(2:end-1);    % Multiply the amplitude of positive frequencies by factor of 2
psd_freq = 0:Fs/length(auto_cor):Fs/2;

subplot(3,1,3);
plot(psd_freq, 10*log10(data_psd));
xlabel('frequency(Hz)');
ylabel('Amplitude');
title('PSD of the Sampled Signal');

% Display some basic statistics
mean_x = mean(data); % mean of signal
std_x = std(data); % standard deviation of signal
max_x = max(data); % maximum value of signal
min_x = min(data); % minimum value of signal
fprintf('Mean: %.2f\n',mean_x)
fprintf('Standard deviation: %.2f\n',std_x)
fprintf('Maximum: %.2f\n',max_x)
fprintf('Minimum: %.2f\n',min_x)





%========================================================================



% Task 4.2 b)
close all;
clc;


N = 4096;    % Number of samples
Fs = 100;   % Sampling Frequency
t = (0:N-1)/Fs;
f1 = 8;
a1 = 0.05;
t1 = (N/2:0:N-1/2)/Fs;

x = sin(2*pi*f1*t) + a1*randn(1,length(t));
N1 = 2*N;   % Number of discrete sampling points in FFT

window_length = 200;
rect_data = rectwin(window_length);
rect_data = [rect_data' zeros(1,N-window_length)];
rect_signal = x.*rect_data;
subplot(4,2,1);
plot(t, rect_signal);
title('Rectanged Signal');
xlabel('Time (s)');
ylabel('Amplitude');

hamm_data = hamming(2*window_length);
hamm_data = hamm_data(window_length+1:end);
hamm_data = [hamm_data' zeros(1, N-window_length)];
hamm_data = hamm_data';
hamm_signal = x.*hamm_data';
subplot(4,2,2);
plot(t, hamm_signal);
title('Hammed Signal');
xlabel('Time (s)');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rectanged Signal
[rect_auto_cor,rect_lags] = xcorr(rect_signal);
size_of_rect_ACF = length(rect_auto_cor);
rect_tau = rect_lags/Fs;
subplot(4,2,3);
plot(rect_tau,rect_auto_cor);
xlabel('Time lags(s)');
ylabel('Amplitude');
title('ACF of the rectanged Sampled Signal');

rect_data_fft = fft(rect_auto_cor);
rect_data_fft = rect_data_fft(1:N1/2);   % Take positive frequencies only
rect_data_psd = (1/(Fs*N1))  * abs(rect_data_fft).^2; % Calculate PSD 
rect_data_psd(2:end-1) = 2*rect_data_psd(2:end-1);    % Multiply the amplitude of positive frequencies by factor of 2
rect_psd_freq = 0:Fs/length(rect_auto_cor):Fs/2;

subplot(4,2,5);
plot(rect_psd_freq, rect_data_psd);
xlabel('frequency (Hz)');
ylabel('Amplitude');
title('PSD of the rectanged Sampled Signal')

subplot(4,2,7);
plot(rect_psd_freq, 10*log10(rect_data_psd));
xlabel('frequency (Hz)');
ylabel('Amplitude (dB)');
title('PSD of the rectanged Sampled Signal in decibels (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hammed Signal
[hamm_auto_cor,hamm_lags] = xcorr(hamm_signal);
size_of_hamm_ACF = length(hamm_auto_cor);
hamm_tau = hamm_lags/Fs;
subplot(4,2,4);
plot(hamm_tau,hamm_auto_cor);
xlabel('Time lags(s)');
ylabel('Amplitude');
title('ACF of the hammed Sampled Signal');

hamm_data_fft = fft(hamm_auto_cor);
hamm_data_fft = hamm_data_fft(1:N1/2);   % Take positive frequencies only
hamm_data_psd = (1/(Fs*N1))  * abs(hamm_data_fft).^2; % Calculate PSD 
hamm_data_psd(2:end-1) = 2*hamm_data_psd(2:end-1);    % Multiply the amplitude of positive frequencies by factor of 2
hamm_psd_freq = 0:Fs/length(hamm_auto_cor):Fs/2;

subplot(4,2,6);
plot(hamm_psd_freq, hamm_data_psd);
xlabel('frequency (Hz)');
ylabel('Amplitude');
title('PSD of the hammed Sampled Signal')

subplot(4,2,8);
plot(hamm_psd_freq, 10*log10(hamm_data_psd));
xlabel('frequency (Hz)');
ylabel('Amplitude (dB)');
title('PSD of the hammed Sampled Signal in decibels (dB)')
close all;
clear all;
N=2000; % Number of samples
f1=1; % Frequency of the sinewave
FS=20; % Sampling Frequency: perfect reconstruction of signal
%possible when the sampling frequency is greater than twice max freq (Nyquist)
n=0:N-1; % Sample index numbers
x=2*sin(2*pi*f1*n/FS); % Generate the signal, x(n)
t=(1:N)*(1/FS); % Prepare a time axis
subplot(3,1,1); % Prepare the figure
plot(t,x); % Plot x(n)
ylim([-3 3]) % y axes (-3 3)
title('Sinwave');
xlabel('Time, [s]');
ylabel('x(t)');
grid;
[xc,lags] = xcorr(x); % Autocorrelation of same functions.
tau = lags*1/FS; % time period.
subplot(3,1,2); % Prepare the figure.
y1 =xc/N*2;
plot(tau,xc/N*2) % changing from sample domain to time domain.
title('Autocorrelation function of the sine function');
xlabel('\tau (s)');
ylabel('x(t)*x(t)');
ylim([-6 6])
Rxxdft = (fftshift(abs(fft(xc/N*2)))); % PSD from autocorrelation function
fs=N;
freq = [-N/2+N/(2*length(xc)):N/length(xc):N/2];
subplot(3,1,3);
plot(freq,Rxxdft/fs*2);
xlim([-110 110])
ylim([0 6])
xlabel('frequency in Hz');
ylabel('PSD');
title('PSD of the sine wave');
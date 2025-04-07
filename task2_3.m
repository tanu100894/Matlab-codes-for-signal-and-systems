clear all
close all
clc;

% Parameters
f = 1; % Frequency in Hz
Fs = 200; % Sampling frequency in Hz
N = 1000; % Number of samples 
t = (-(N/2):(N/2)-1)/Fs; % Time vector          

% Signal
y = sin(2*pi*f*t);

%Plot the sinewave
figure;
subplot(4, 2, 1);
plot(t, y);
title("Sinewave")
xlim([-3.5 3.5])
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%(a)
%Always remember the window length an = a + (n-1)*d
%Generate a rectangular window with length of number of samples
% window_length_rect = 3;
window_length_rect = 2.5;
rect_win = rectwin(window_length_rect*Fs)';
% rect_Window = [zeros(1, Fs) rectwin(window_length_rect*Fs)' zeros(1, Fs)];
rect_Window = [zeros(1, 250) rectwin(window_length_rect*Fs)' zeros(1, 250)];
% rect_Window = [zeros(1,Fs), rect_signal];
% rect_Window = [rect_signal, zeros(1,Fs)];

%Plot the rectangular pulse data
subplot(4, 2, 2);
plot(t, rect_Window)
xlim([-2.5 2.5])
ylim([0 2])
title("Rectangular Window")
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%Apply rectangular window on sine wave
rect_signal = y .* rect_Window;


%Plot the rectangled sinosuidal wave 
subplot(4, 2, 3);
plot(t, rect_signal)
xlim([-2.5 2.5])
title("Rectangled Sine Wave")
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%Find the correlation
[correlationOfRectSignal, rectLags] = xcorr(rect_signal, 'biased');
tauRect = rectLags/Fs;

%Plot the correlated signal
subplot(4, 2, 4)
plot(tauRect, correlationOfRectSignal)
xlim([-7 7])
title("Auto Correlation of RectWin and Sinwave")
xlabel("normalized tauRect")
ylabel("y(t)*y(t)")
grid;

%(b)
%Generate a hamming window with length of number of samples
% window_length_hamm = 3;
window_length_hamm = 2.5;
% hamm_Window = [zeros(1, Fs) hamming(window_length_hamm*Fs)' zeros(1, Fs)];
hamm_Window = [zeros(1, 250) hamming(window_length_hamm*Fs)' zeros(1, 250)];
% rect_signal = [zeros(1,Fs), rect_signal];
% rect_signal = [rect_signal, zeros(1,50)];

%Plot the sinewave again
subplot(4, 2, 5);
plot(t, y);
title("Sinewave")
xlim([-3.5 3.5])
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%Plot the hamming window data
subplot(4, 2, 6);
plot(t, hamm_Window)
xlim([-2.5 2.5])
ylim([0 2])
title("Hamming Window")
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%Apply hamming window on sine wave
hamm_signal = y .* hamm_Window;


%Plot the hammed sinosuidal wave 
subplot(4, 2, 7);
plot(t, hamm_signal)
xlim([-2.5 2.5])
title("Hammed Signal")
xlabel("Time [s]")
ylabel("Amplitude")
grid;

%Find the correlation
[correlationOfHammedSignal, hammLags] = xcorr(hamm_signal, 'biased');
tauHamm = hammLags/Fs;

%Plot the correlated signal
subplot(4, 2, 8)
plot(tauHamm, correlationOfHammedSignal)
xlim([-7 7])
title("Auto Correlation of HammWin and Sinwave")
xlabel("normalized tauHamm")
ylabel("y(t)*y(t)")
grid;

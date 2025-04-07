clear all;
clc;
close all;
% Number of samples 
N = 600;

% Given Frequency of the sinewave 
f1=1;

% sampling frequency
FS = 100;

% time axis will begin from -1.5 to 1.5 
t = (-N/2:N/2-1)*1/FS; 
t1 = -3.5:0.01:3.5;

% Defining sine wave
y = sin(2*pi*f1*t1);

% Genrating the bigger plot for all examples 
figurel= figure('Position',[200, 200, 1500, 1500]);

% Define the position 4 rows 2 columns position 1
subplot(4,2,1);

% Plot generated with respect to time domain and y is Sin wave. 
plot(t1,y,'g','LineWidth',2); 
title("Sine wave");
xlim([-3.5 3.5]); 
xlabel ("Time in secs");
ylabel ("Amplitude"); 
grid;

% Define the position 4 rows 2 columns position 2. 
subplot(4,2,2);

% Plot generated with respect to time domain and y is Sin wave 
plot(t1, y, 'g', 'LineWidth', 2); 
xlim([-3.5 3.5]); 
title("Sine wave"); 
xlabel("Time in secs"); 
ylabel("Amplitude");
grid;

% Generates hamming window of length same as no of smaples as t. 
ham = hamming(length(t));

% Define the position 4 rows 2 columns position 3 
subplot(4,2,3);

% Plot generated W.r.t time domain and hamming window. 
Ham_Data = [zeros(1,50), ham']; 
Ham_Data=[Ham_Data zeros(1,50)]; 
Ham_data = Ham_Data';
t1(end) = [];

plot(t1, Ham_data-1, 'r','LineWidth', 2);
title("Hamming window");
xlim([-3.5 3.5]); 
xlabel ("Time in secs");
ylabel( "Amplitude" ); 
grid;

% Generates rectangular window of length same as no of smaples as t 
rect = rectwin(length(t)); 
Rect_Data = [zeros(1,50), rect']; 
Rect_Data = [Rect_Data zeros(1,50)];

% Define the position 4 rows 2 columns position 4 
subplot (4,2,4);

% Plot generated W.r.t time domain with rectangular window.
plot(t1, Rect_Data, 'r', 'LineWidth', 2); 
xlim([-3.5 3.5]);
ylim([0 2]); 
title("Rectangular Window");
xlabel("Time in secs");
ylabel("Amplitude");
grid;

% Using hamming window on sinosodal signal
y = sin(2*pi*f1*t); 
hammedSignal = y.*ham';

hammedSignal_Data = [zeros(1,50), hammedSignal]; 
hammedSignal_Data = [hammedSignal_Data zeros(1,50)];

% Define the position 4 rows 2 columns position 5 
subplot (4,2,5);

% Plot generated w.r.t time domain with Hammed Signal. 
plot(t1, hammedSignal_Data, 'r', 'LineWidth', 2); 
title("Hammed Signal"); 
xlim([-3.5 3.5]); 
xlabel("Time in secs"); 
ylabel ("Amplitude");
grid;

% converted the row into col impulse repsonse 
% Applying the window on whole signal
rectSignal = y.*rect'; 
rectSignal_Data = [zeros(1,50), rectSignal];
rectSignal_Data = [rectSignal_Data zeros(1,50)];

% Define the position 4 rows 2 columns position 6 
subplot (4,2,6);

% Plot generated w.r.t time domain with rectanged Signal. 
plot(t1, rectSignal_Data, 'r','LineWidth',2); 
title("Rectanged signal"); 
xlim([-3.5 3.5]); 
xlabel("Time in secs"); 
ylabel("Amplitude"); 
grid;

% To normalise the y axis we are passing the ‘biased’ on Hammed Signal.
[correlationOfHammedSignal, hammedLags] = xcorr (hammedSignal_Data, 'biased'); 

% To normalise the y axis we are passing the ‘biased’ on Rectanged Signal. 
[correlationOfRectSignal, rectLags] = xcorr(rectSignal_Data, 'biased');

% To normalise the tau for Hamming Lags we have to multiply by 1/Fs 
tauH = hammedLags*1/FS; 

% To normalise the tau for we have to multiply by 1/Fs 
tausR = rectLags*1/FS;

% Define the position 4 rows 2 columns position 7 
subplot(4,2,7); 

% Correlated hammed signal plotting with the same sin wave w.r.t tauH 
plot(tauH, correlationOfHammedSignal, 'r', 'LineWidth',2); 
title("Auto correlated Hammed signal");
xlim([-7 7]); 
xlabel("\taus"); 
ylabel("x(t) * x(t)");

% Define the position 4 rows 2 columns position 8
subplot(4,2,8); 

% Correlated rectanged signal plotting w.r.t tausR
plot(tausR, correlationOfRectSignal, 'r', 'LineWidth',2); 
title("Auto correlated Rectaged signal"); 
xlim([-7 7]); 
xlabel("\taus"); 
ylabel("x(t) * x(t)"); 


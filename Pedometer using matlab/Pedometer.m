clc
close all
clear all
%% loading the recorde
load("walking2.mat"); 

% defining axis signals
X = Acceleration(:,1); % X axis
Y = Acceleration(:,2); % Y axis
Z = Acceleration(:,3); % Z axis

% defining time span
beginningTime = 1;
data_size = size(X.X);
samplesnumb = data_size(1) - beginningTime + 1;
t = beginningTime : 1 : data_size(1);

% this part is for changing the beginning time
for i = 1:samplesnumb
    data_X(i) = X.X(i + beginningTime -1);
    data_Y(i) = Y.Y(i + beginningTime -1);
    data_Z(i) = Z.Z(i + beginningTime -1);
end

%% Generating noise and the noisy signals
noisePower = 1; % noise power
noise = wgn(samplesnumb,1,noisePower); % creating white noise
noise = transpose(noise);
data_X = data_X + noise; % noisy signal X axis 
data_Y = data_Y + noise; % noisy signal Y axis 
data_Z = data_Z + noise; % noisy signal Z axis 

% plotting noisy signals
figure(1)
subplot(3,1,1);
plot(t,data_X);
grid on
axis tight
title('Noisy Signal X')
xlabel('Time(s)')
subplot(3,1,2);
plot(t,data_Y);
grid on
axis tight
title('Noisy Signal Y')
xlabel('Time(s)')
subplot(3,1,3);
plot(t,data_Z);
grid on
axis tight
title('Noisy Signal Z')
xlabel('Time(s)')

%% Filtering
% creating bandpass filter of 0.2 t0 4 HZ
Fs = 100; % Sampling frequency
d = designfilt('bandpassfir', 'FilterOrder', 30, ... 
    'CutoffFrequency1', 0.2, 'CutoffFrequency2', 4, 'SampleRate', Fs);

% filtering signals of each axis
data_X = filter(d,data_X);
data_Y = filter(d,data_Y);
data_Z = filter(d,data_Z);

% plotting filtered signals
figure(2)
subplot(3,1,1);
plot(t,data_X);
grid on
axis tight
title('Filtered Signal X')
xlabel('Time(s)')
subplot(3,1,2);
plot(t,data_Y);
grid on
axis tight
title('Filtered Signal Y')
xlabel('Time(s)')
subplot(3,1,3);
plot(t,data_Z);
grid on
axis tight
title('Filtered Signal Z')
xlabel('Time(s)')

%% Generating main accelerometer signal with signal axises
a = (data_X.^2 + data_Y.^2 + data_Z.^2).^0.5;
% plotting the signal in time domain
figure(4)
plot(t,a);
grid on
axis tight
title('Combined Signal of Accelerometer')
xlabel('Time(s)')

% plotting forier transform of the signal
A = fft(a); 
A = fftshift(A);
N = length(A);
f = [-N/2:N/2-1];
figure(5)
plot(f,A);
grid on
axis tight
title(' Fourier Transform of Combined Signal of Accelerometer')
xlabel('Time(s)')

%% Generating pulse wave
threshold = 11.7;
max_thresh = 16;
min_thresh = 8;
for i = 1 : samplesnumb
    if a(i) >= threshold && a(i) < max_thresh
        pulse(i) = 1;
    elseif a(i) < threshold
        pulse(i) = 0;
    end
end

% plotting pulse wave
figure(6)
plot(t,pulse);
grid on
axis tight
title('Pulse Signal of Pedometer')
xlabel('Time(s)')

%% Counting steps
changeFlag = 0;
counter = 0;
for i = 1 : samplesnumb
    if pulse(i) == 1 && changeFlag == 0
        counter = counter + 1;
        changeFlag = 1;
    elseif pulse(i) == 0 && changeFlag == 1
        changeFlag = 0;
    end
end
% plotting Steps Number
figure(7)
stem(counter);
grid on
title('Number of Steps is:')
ylabel('number of steps')
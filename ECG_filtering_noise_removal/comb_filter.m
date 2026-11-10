% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load("ecg_signal_1.dat");

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load("ecg_signal_2.dat");

N = 10; 
b_moving_average = ones(1, N) / N;
%b_moving_average = 1;
%a_moving_average = 1;

b_derivative = [1 -1];
a_derivative = [1 -0.995];

freq_response = freqz(b_derivative, a_derivative, 512, FS);
b_derivative = b_derivative / real(max(freq_response));

b_comb = [0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310];

% Create cascaded filter coefficients a and b using convolution
b = conv(conv(b_comb, b_moving_average), b_derivative);
a = a_derivative;

% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered = filter(b,a, ecg1);
% ...and ecg2
ecg2_filtered = filter(b,a, ecg2);

figure

subplot(4,2,1)
plot( (0:length(ecg1)-1)/FS, ecg1 )
hold on
plot( (0:length(ecg1_filtered)-1)/FS, ecg1_filtered )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 1')
xlim([0 length(ecg1)/FS])
ylim([-2 3])
legend('original','filtered');

subplot(4,2,2)
plot( (0:length(ecg2)-1)/FS, ecg2 )
hold on
plot( (0:length(ecg2_filtered)-1)/FS, ecg2_filtered )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 2')
xlim([0 length(ecg2)/FS])
ylim([-2 3])
legend('original','filtered');

subplot(4,2,3)
plot( (0:length(ecg1)-1)/FS, ecg1 )
hold on
plot( (0:length(ecg1_filtered)-1)/FS, ecg1_filtered )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 1')
xlim([2 3])
ylim([-2 3])
legend('original','filtered');

subplot(4,2,4)
plot( (0:length(ecg2)-1)/FS, ecg2 )
hold on
plot( (0:length(ecg2_filtered)-1)/FS, ecg2_filtered )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 2')
xlim([1 2])
ylim([-2 3])
legend('original','filtered');

subplot(4,2,5)
periodogram(ecg1,[],[],FS)
title('Original PSD')
ylabel('Power [a.u.]')

subplot(4,2,6)
periodogram(ecg2,[],[],FS)
title('Original PSD')
ylabel('Power [a.u.]')

subplot(4,2,7)
periodogram(ecg1_filtered,[],[],FS)
title('Filtered PSD')
ylabel('Power [a.u.]')

subplot(4,2,8)
periodogram(ecg2_filtered,[],[],FS)
title('Filtered PSD')
ylabel('Power [a.u.]')

figure
freqz(b,a,[],FS); 
title('Frequency response of the MA filter');

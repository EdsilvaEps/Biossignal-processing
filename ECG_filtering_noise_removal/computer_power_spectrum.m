% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load("assignment2\ecg_signal_1.dat");

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load("assignment2\ecg_signal_2.dat");

% Compute ECG 1 power spectrum
N1 = length(ecg1);
P_ecg1 = fft(ecg1) .* conj(fft(ecg1)) / N1;

% Compute ECG 2 power spectrum
N2 = length(ecg2);
P_ecg2 = fft(ecg2) .* conj(fft(ecg2)) / N2;

% Compute power spectrum frequency bins from 0 Hz to the Nyquist frequency
% For ECG 1
f1 = (0: (N1/2)) * FS/N1;
% ...and for ECG 2
f2 = (0: (N2/2)) * FS/N2;

figure

subplot(2,2,1)
plot( (0:length(ecg1)-1)/FS, ecg1 )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 1')
xlim([0 length(ecg1)/FS])
ylim([-2 3])

subplot(2,2,2)
plot( (0:length(ecg2)-1)/FS, ecg2 )
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 2')
xlim([0 length(ecg2)/FS])
ylim([-2 3])

subplot(2,2,3)
semilogy(f1, P_ecg1(1:length(f1)));    
xlim([f1(1) f1(end)])
ylim([0 100]);
title('ECG 1 Power Spectrum');
xlabel('Frequency [Hz]');
ylabel('Power [a.u.]');

subplot(2,2,4)
semilogy(f2, P_ecg2(1:length(f2)));    
xlim([f2(1) f2(end)])
ylim([0 100]);
title('ECG 2 Power Spectrum');
xlabel('Frequency [Hz]');
ylabel('Power [a.u.]');

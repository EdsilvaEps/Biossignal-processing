
% Select and plot data
% using a script instead of functions so individual variables can be analysed

% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load("assignment2\ecg_signal_1.dat");

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load("assignment2\ecg_signal_2.dat");

% Select the interval [2 s, 3s] samples from ECG 1 
ecg1_interval = ecg1(2*FS+1:3*FS+1);

% Sample times for the interval 1
ecg1_interval_t = linspace(2,3,length(ecg1_interval));

% Select the interval [1 s, 2s] samples from ECG 2
ecg2_interval = ecg2(1*FS+1 : 2*FS+1);

% Sample times for the interval 2
ecg2_interval_t = linspace(1,2, length(ecg2_interval));

% plotting 
figure;
tiledlayout(2,2);

% Plot ECG 1
nexttile;
plot( (0:length(ecg1)-1)/FS, ecg1 )
ylabel('ECG amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 1')
xlim([0 length(ecg1)/FS])
ylim([-2 3])


% Plot ECG 1 interval
nexttile;
plot(ecg1_interval_t, ecg1_interval);
title('ECG 1 Interval [2s, 3s]');
xlabel('Time (s)');
ylabel('Amplitude [a.u.]');

% Plot ECG 2
nexttile;
plot( (0:length(ecg2)-1)/FS, ecg2 )
ylabel('ECG amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 2')
xlim([0 length(ecg2)/FS])
ylim([-2 3])


% Plot ECG 2 interval
nexttile;
plot(ecg2_interval_t, ecg2_interval);
title('ECG 2 Interval [1s, 2s]');
xlabel('Time (s)');
ylabel('Amplitude [a.u.]');

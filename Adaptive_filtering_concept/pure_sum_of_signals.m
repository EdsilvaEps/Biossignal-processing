% Load problem1.mat to have access to variables abd_sig1 and mhb
load("assignment3/problem1.mat");

% hint: you need to check the content of the problem1.mat locally to load it in the correct way!

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
ending_time = length(abd_sig1)/FS;
t = linspace(0, ending_time, length(abd_sig1));

% Estimate c2 from abd_sig1 and mhb using the scalar projection formula
% c2 = xT * x2 / x2T * x2 -> where x is the combined signal and x2 is the mothers signal
c2_projection = (abd_sig1' * mhb) / (mhb' * mhb); 

% Estimate c2 from abd_sig1 and mhb using the pseudoinverse function (pinv)
c2_pinv = pinv(mhb)*abd_sig1;

% Estimate c2 from abd_sig1 and mhb using the backslash operator (\)
c2_operator = mhb \ abd_sig1;

% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection based estimation coefficient
fetus = abd_sig1 - c2_projection*mhb;

figure

subplot(311)
plot( t, abd_sig1, 'b' )
hold on
plot( t, mhb, 'r--' )
legend('abd\_sig1 (x = x_1 + c_2 x_2)','mhb (y = x_2)')
xlabel('t [s]')
ylabel('amplitude [a.u.]')
ylim([-2 4]);

subplot(312)
plot( t, c2_projection * mhb, 'b'  )
legend('scaled mhb (c_2 x_2)')
xlabel('t [s]')
ylabel('amplitude [a.u.]')
ylim([-2 4]);

subplot(313)
plot( t, fetus, 'b' )
hold on
plot( t, fhb, 'r--' );
legend('estimated fetus (x - y = x - c_2 x_2)', 'true fetus')
xlabel('t [s]')
ylabel('amplitude [a.u.]')
ylim([-2 4]);
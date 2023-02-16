% Time Series
% Q2, Q3
n = length(normal);
[ACF_n, lags_n] = autocorr(normal);
[ACF_e, lags_e] = autocorr(epileptic);

figure;
subplot(2, 2, 1);
plot(epileptic);
ylabel("Voltage");
xlabel("Times(ms)");
title("Epileptic Group");

subplot(2, 2, 2);
plot(lags_e(1: end), ACF_e(1:end));
ylabel("Autocorr_coeff");
xlabel("Times(ms)");
title("Autocorrelation of epileptic");

subplot(2, 2, 3);
plot(normal);
ylabel("Voltage");
xlabel("Times(ms)");
title("Normal Group");

subplot(2, 2, 4);
plot(lags_n(1: end), ACF_n(1:end));
ylabel("Autocorr_coeff");
xlabel("Times(ms)");
title("Autocorrelation of normal");

% Q4
Fs = 1000; % sampling frequence
T = 1/Fs;
dft = fft(epileptic);
dft = fftshift(dft);
re = real(dft);
im = imag(dft);
% Important: Frequecy vector
freq = (-Fs/2:Fs/n:Fs/2-Fs/n);
% Nyquist Frequency is 500 Hz, Because:
% Fs = 1/Ts; % Sampling Frequency
% Fn = Fs/2; % Nyquist Frequency
figure;
subplot(3, 1, 1);
plot(freq, re, 'red');
title("Real Part of FFT");
subplot(3, 1, 2);
plot(freq, im, 'blue');
title("Imaginary Part of FFT");
subplot(3, 1, 3);
plot(freq, abs(dft), 'green');
title("Magnitude")

% Q6
% power specturm
power = abs(dft).^2;
figure;
subplot(2, 1, 1);
plot(freq(n/2:n/2+400),power(n/2:n/2+400));
xlabel('Frenquency in Hz'); 
ylabel('Power'); 
title('Power spectrum by FFT method in linear');
subplot(2, 1, 2);
plot(freq(n/2:n/2+400),10*log10(power(n/2:n/2+400)));
xlabel("Frequency in Hz");
ylabel("Power");
title("Power Spectrum by FFT method in dB");








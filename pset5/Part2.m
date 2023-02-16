%% Filter
load("EEGepilepsy.mat")
%% Q1
Fs = 1000; % Hz
T = 1/Fs;
n = length(epileptic);
dft = fft(epileptic);
dft_m = dft(1:n/2+1)/n;
dft_m(2:n/2+1) = 2*dft_m(2:n/2+1);
freq = (0:n/2)*(Fs/n);
figure(1);
plot(freq, abs(dft_m)); %Amplitude, Magnitude, 二者区别？
for i = 1:length(dft_m)
    if abs(dft_m(i)) >= 0.5
        dft_m(i) = 0;
        dft(i) = 0; %index align
        dft(n+2-i) = 0;
    end
end
freq2 = (-Fs/2:Fs/n:Fs/2-Fs/n);
figure(2);
plot(freq2, abs(dft));
xlabel("Frequency in Hz");
ylabel("Amplitude");

time_f = ifft(dft);
figure(3);
plot(epileptic, 'red');
hold on;
plot(time_f, 'blue');
hold off;
legend('raw', 'filter');
xlabel("Time in ms");
ylabel("Amplitude");
title("Filter Data");

%% Q2
dft_f = abs(fft(time_f)).^2/n;
dft_f = dft_f(1:n/2+1);
dft_f(2:end-1) = 2*dft_f(2:end-1);
freq_80 = (0:400)*(Fs/n);
figure(4);
plot(freq_80, dft_f(1:401));
xlabel("Frequency in Hz");
ylabel("Amplitude");

%% Q3: Padded Periodogram
dt = 1 ;              % sampling interval in ms
n2 = 5000*5;          % no of samples in time

% Nyquist Frequency is 500 Hz
% padded = [time_f zeros(1,5000*4)];
U=fft(time_f, 25000);

freq3 = (0:(n2/2))* (Fs/n2);  % for the x ticks
%Frequency resolution is 0.2 Hz

mag=abs(U).^2/n; %% 这个一个关键问题补0为什么还是/n
P1 = mag(1:n2/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(5);
plot(freq3(1:2001),P1(1:2001)); %restricting frequency to 80 Hz
xlabel('Frenquency in Hz'); 
ylabel('Amplitude'); 
title('Power spectrum by FFT method in linear(Zero Padding)');

%% Multi-taper Analysis
TW = [1.5 2 5];
% [spec, freqs, times] = WSpecgram(time_f, 1.5, 1, );
% surf(spec);
figure(6);
for i = 1:length(TW)
    [Spec, Fvec] = WSpec(time_f,TW(i),1,0,1000);
    subplot(3,1,i);
    plot(Fvec(1:80),Spec(1:80));
    xlabel("Frequency");
    ylabel("Spectrum");
end

%% Multi-taper Analysis with zero padding
TW = [1.5 2 5];
% [spec, freqs, times] = WSpecgram(time_f, 1.5, 1, );
% surf(spec);
figure(7);
zp = 5;
for i = 1:length(TW)
    [Spec, Fvec] = WSpec(time_f,TW(i),1,5,1000);
    subplot(3,1,i);
    plot(Fvec(1:400),Spec(1:400));
    xlabel("Frequency");
    ylabel("Spectrum");
end

%% Spectrogram
[Specgram, Fvec, Tvec] = WSpecgram(time_f, 2, 1, 0.05, 5, 1000);
figure(8);
surf(Tvec,Fvec,Specgram,'edgecolor','none');
view(2);
ylim([0 30]);
colorbar;
xlabel("Time in sec");
ylabel("Frequency in Hz");
title("Spectogram of Epileptic Signal");

%% Normal Data
[Specgram, Fvec, Tvec] = WSpecgram(normal, 2, 1, 0.05, 5, 1000);
figure(9);
surf(Tvec,Fvec,Specgram,'edgecolor','none');
view(2);
ylim([0 30]);
colorbar;
xlabel("Time in sec");
ylabel("Frequency in Hz");
title("Spectogram of Normal Signal");


%% Test
fs = 10;
t_dur = 1 / fs;
t = (1:500)*t_dur;
signal = cos(2*pi*t) + 2*cos(3*pi*t) + 3*cos(4*pi*t);
figure;
plot(signal);

dft = fft(signal)/500 * 2;
dft = dft(1:251);
freq = (0:250)*(fs/250);
plot(freq, abs(dft));



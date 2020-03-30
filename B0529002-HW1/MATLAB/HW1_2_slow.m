[y,fs]=audioread('Nello.wav');

fs2=fs/2;
Y=fft(y);
Y2=ifft(Y);

audiowrite('HW1_2_slow.wav',Y2,fs2);

time1 = (1:length(y))/fs;
time2 = (1:length(Y2))/fs2;
subplot(2,1,1);
plot(time1,y);
subplot(2,1,2);
plot(time2,Y2);
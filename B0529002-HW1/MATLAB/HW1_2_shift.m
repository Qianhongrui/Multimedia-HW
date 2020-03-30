[y,fs] = audioread('Nello.wav'); 
len = length(y);
N = 32;
dctA = zeros(len,1);
dctB = zeros(len,1);
idctC = zeros(len,1);
for i = 1:(len-N+1)
    if rem(i,N) == 1
        dctA(i:(i+N-1)) = dct(y(i:(i+N-1)));
    end
end
for i=1:len
    if i==1
        dctB(1) = dctA(1);
    elseif i==2
        dctB(2) = dctA(2);
    else
        dctB(i) = dctA(i-2);
    end
end
for i = 1:(len-N+1)
    if rem(i,N) == 1
        idctC(i:(i+N-1)) = idct(dctB(i:(i+N-1)));
    end
end
filename = 'HW1_2_shift.wav'; 
audiowrite(filename,idctC,fs,'BitsPerSample',8); 
clear;

%check original&output file
[y1, fs1] = audioread('Nello.wav');
[y2, fs2] = audioread('bonus_shift.wav');
time1 = (1:length(y1))/fs1;
time2 = (1:length(y2))/fs2;
subplot(2,1,1);
plot(time1,y1);
subplot(2,1,2);
plot(time2,y2);
clear;
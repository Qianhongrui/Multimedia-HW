location = 'C:\Users\Qian HongRui\Desktop\HW1\';
readFileName = [location 'Nello.wav'];       
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_2_echo01.wav'];     

delay=0.2;
gain=0.8;
a = [1];
b = [1, zeros(1, round(delay*fs)-1), gain];

y = filter(b, a, x);                              %ÂË²¨

time = ( 1:length(x) )/fs; 
subplot(2,1,1);                                
plot(time,x);
subplot(2,1,2);                                 
plot(time,y);

audiowrite( saveFileName, y, fs );                

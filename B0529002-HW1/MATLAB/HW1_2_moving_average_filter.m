location = 'C:\Users\Qian HongRui\Desktop\HW1\';
readFileName = [location 'Nello.wav'];       
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_2_moving_average_filter.wav'];     

windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

y = filter(b, a, x);                        

time = ( 1:length(x) )/fs; 
subplot(2,1,1);                                
plot(time,x);
subplot(2,1,2);                                 
plot(time,y);

audiowrite( saveFileName, y, fs );                

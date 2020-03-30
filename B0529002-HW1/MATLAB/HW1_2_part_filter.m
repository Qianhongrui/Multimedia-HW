location = 'C:\Users\Qian HongRui\Desktop\HW1\';
readFileName = [location 'Nello.wav'];       
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_2_part_filter.wav'];     

x1 = x(1:15);
x2 = x(16:end);

b = [2,3];
a = [1,0.2];
[y1,zf] = filter(b,a,x1);
y2 = filter(b,a,x2,zf);

y = filter(b, a, x);                              %ÂË²¨

time = ( 1:length(x) )/fs; 
subplot(2,1,1);                                
plot(time,x);
subplot(2,1,2);                                 
plot(time,y);

audiowrite( saveFileName, y, fs );                

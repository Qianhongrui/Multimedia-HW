location = 'C:\Users\Qian HongRui\Desktop\HW1\';
readFileName = [location 'Nello.wav'];       
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_2_low_filter.wav'];     

%cutOffFreq = 800;	                               %Cutoff frequency
cutOffFreq = 200;
filterOrder = 5;	                               %Order of filter
[b, a] = butter(filterOrder, cutOffFreq/(fs/2), 'low'); 

y = filter(b, a, x);                              %ÂË²¨

time = ( 1:length(x) )/fs; 
subplot(2,1,1);                                
plot(time,x);
subplot(2,1,2);                                 
plot(time,y);

audiowrite( saveFileName, y, fs );                

location = 'C:\Users\Qian HongRui\Desktop\HW1\';  
readFileName = [location 'Nello.wav'];              
[x,fs] = audioread( readFileName );                 
saveFileName = [location 'HW1_2.wav'];     

N = 32;                                   %分段
row = size( x, 1 );                       %资料总大小
tempNum = ceil( row/N );                  %总分段数
x2 = zeros( tempNum *N, 1 );              %空矩阵
temp = zeros( N, 1 );                     %存放分段资料
randNum = unidrnd(N-1);                   %乱数，显示明断频谱

cutOffFreq = 800;	                      %Cutoff frequency
filterOrder = 5;	                      %Order of filter
[b, a] = butter(filterOrder, cutOffFreq/(fs/2), 'low'); 

for i=1: tempNum                       
	if i== tempNum                        %单独出最后一段
		temp(1:N-(N*i-row),1) = x(N*(i-1)+1:row,1);
	else
		temp(1:N) = x(N*(i-1)+1:N*i,1);
	end
	afterDct = dct(temp);                  %DCT
                                           %设计低通滤波器
    y = filter(b, a, afterDct);            %滤波
	afterIdct = idct(y);                   %IDCT

	x2( N*(i-1)+1:N*i,1 ) = afterIdct;     %运算结果存到空矩阵
end
time = ( 1:length(x) )/fs; 
time2= ( 1:length(x2) )/fs; 
subplot(2,1,1);
plot(time,x);
subplot(2,1,2);
plot(time2,x2);
audiowrite( saveFileName, x2, fs );        %存档
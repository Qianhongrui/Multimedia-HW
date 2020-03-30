location = 'C:\Users\Qian HongRui\Desktop\HW1\';  
readFileName = [location 'Nello.wav'];           
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_1.wav']; 

N = 32;                                   %或者64/128/256资料分段
row = size( x, 1 );                       %资料大小
tempNum = ceil( row/N );                  %段数
x2 = zeros( tempNum *N, 1 );              %存放运算结果
temp = zeros( N, 1 );                     %存放分段资料
randNum = unidrnd(N-1);                   %随机显示某段频谱

for i=1: tempNum                        
	if i== tempNum                        %最后一段单独出来
		temp(1:N-(N*i-row),1) = x(N*(i-1)+1:row,1);
	else
		temp(1:N) = x(N*(i-1)+1:N*i,1);
	end
	afterDct = dct(temp);                  %DCT
	afterIdct = idct(afterDct);            %IDCT
    if i==randNum
        subplot(2,1,1);
        plot(temp);
        subplot(2,1,2);
        plot(afterIdct);
    end

	x2( N*(i-1)+1:N*i,1 ) = afterIdct;   
end

%time = ( 1:length(x) )/fs; 
%subplot(2,1,1);                                
%plot(time,x);
%subplot(2,1,2);                                 
%plot(time,y);

audiowrite( saveFileName, x2, fs );    
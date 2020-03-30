location = 'C:\Users\Qian HongRui\Desktop\HW1\';  
readFileName = [location 'Nello.wav'];           
[x,fs] = audioread( readFileName );        
saveFileName = [location 'HW1_1.wav']; 

N = 32;                                   %����64/128/256���Ϸֶ�
row = size( x, 1 );                       %���ϴ�С
tempNum = ceil( row/N );                  %����
x2 = zeros( tempNum *N, 1 );              %���������
temp = zeros( N, 1 );                     %�s��ŷֶ�����
randNum = unidrnd(N-1);                   %�����ʾĳ��Ƶ��

for i=1: tempNum                        
	if i== tempNum                        %���һ�ε�������
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
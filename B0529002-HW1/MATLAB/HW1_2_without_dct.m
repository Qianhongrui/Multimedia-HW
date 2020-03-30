location = 'C:\Users\Qian HongRui\Desktop\HW1\';
readFileName = [location 'Nello.wav'];              
[x,fs] = audioread( readFileName );                 
saveFileName = [location 'HW1_2_without_dct.wav'];     

N = 32;                                   %64/128/256�ֶ�
row = size( x, 1 );                       %�����ܴ�С
tempNum = ceil( row/N );                  %�ֶܷ���
x2 = zeros( tempNum *N, 1 );              %�վ���
temp = zeros( N, 1 );                     %�s��ŷֶ�����
randNum = unidrnd(N-1);                   %��������ʾ����Ƶ��

cutOffFreq = 800;	                      %Cutoff frequency
filterOrder = 5;	                      %Order of filter
[b, a] = butter(filterOrder, cutOffFreq/(fs/2), 'low'); 

for i=1: tempNum                          %�ֶν�����������
    if i== tempNum                        %���������һ��
		temp(1:N-(N*i-row),1) = x(N*(i-1)+1:row,1);
	else
		temp(1:N) = x(N*(i-1)+1:N*i,1);
    end

    y = filter(b, a, temp);               %�˲�
	
	x2( N*(i-1)+1:N*i,1 ) = y;     
end
time = ( 1:length(x) )/fs; 
time2= ( 1:length(x2) )/fs; 
subplot(2,1,1);
plot(time,x);
subplot(2,1,2);
plot(time2,x2);
audiowrite( saveFileName, x2, fs );       %�浵
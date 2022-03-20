close all;
clc;
clear;
%%1
Fs=27000;
Rb=18000;
M=4;
Fd=Rb/log2(M);%Rs
t=0:1/Fs:(1/Fd)-(1/Fs);
s1(1:length(t))=1;
%% 2
m=[];
for i=1:1000
    a=randi(4)-1;
    if(a==0)
        m=[m -3*s1];
    elseif(a==1)
        m=[m -s1];
    elseif(a==2)
        m=[m s1];
    elseif(a==3)
        m=[m 3*s1];
    end
end
%% 3
% Rs=Rb/k-->k=2 Rb=18000--> Rs=9000 bits/second
Rs=Rb/log2(M);
%1 symbol has 3 bits
%% 4 
rcos0=rcosdesign(0,10,length(t),'sqrt');
rcos0_5=rcosdesign(0.5,10,length(t),'sqrt');
rcos1=rcosdesign(1,10,length(t),'sqrt');
frcos0=abs(fftshift(fft(rcos0))/length(rcos0));
frcos0_5=abs(fftshift(fft(rcos0_5))/length(rcos0_5));
frcos1=abs(fftshift(fft(rcos1))/length(rcos1));
%% 5
figure;
subplot(231);
plot(linspace((-5/2*Fd),(5/2*Fd),length(rcos0)),rcos0);
xlabel('Time in seconds');
ylabel('Amplitudes');
title('Square Root Rcos with B=0');

subplot(234);
plot(linspace(-Fs/2,Fs/2,length(rcos0)),frcos0);
xlabel('Frequency in Hz');
ylabel('Magnitudes');
title('Square Root Rcos with B=0');

subplot(232);
plot(linspace((-5/2*Fd),(5/2*Fd),length(rcos0)),rcos0_5);
xlabel('Time in seconds');
ylabel('Amplitudes');
title('Square Root Rcos with B=0.5');

subplot(235);
plot(linspace(-Fs/2,Fs/2,length(rcos0_5)),frcos0_5);
xlabel('Frequency in Hz');
ylabel('Magnitudes');
title('Square Root Rcos with B=0.5');

subplot(233);
plot(linspace((-5/2*Fd),(5/2*Fd),length(rcos1)),rcos1);
xlabel('Time in seconds');
ylabel('Amplitudes');
title('Square Root Rcos with B=1');

subplot(236);
plot(linspace(-Fs/2,Fs/2,length(rcos1)),frcos1);
xlabel('Frequency in Hz');
ylabel('Magnitudes');
title('Square Root Rcos with B=1');
%% 6 
tx1=upfirdn(m,rcos0,length(t));
tx2=upfirdn(m,rcos0_5,length(t));
tx3=upfirdn(m,rcos1,length(t));
%% 7 
tx1_20db=awgn(tx1,20,'measured');
tx2_20db=awgn(tx2,20,'measured');
tx3_20db=awgn(tx3,20,'measured');
%% 8
fc1=5400;
fc2=7200;
fc3=9900;
% I know the filter is Ideal 
% but I dont remember 
% how to get b and a coefficients 
% so I have used non ideal butterworth filter 
[c1,d1]=butter(10,fc1/(Fs/2));
[c2,d2]=butter(10,fc2/(Fs/2));
[c3,d3]=butter(10,fc3/(Fs/2));
rx1=filter(c1,d1,tx1_20db);
rx2=filter(c2,d2,tx2_20db);
rx3=filter(c3,d3,tx3_20db);
yout1=upfirdn(tx1_20db,rcos0,1,length(t));
yout2=upfirdn(tx2_20db,rcos0_5,1,length(t));
yout3=upfirdn(tx3_20db,rcos1,1,length(t));
%% 9
yout1f=yout1(1+10:length(yout1)-10);
yout2f=yout2(1+10:length(yout2)-10);
yout3f=yout3(1+10:length(yout3)-10);
%% 10
eyediagram(yout1f,length(t),1/Fs,0);
eyediagram(yout2f,length(t),1/Fs,0);
eyediagram(yout3f,length(t),1/Fs,0);

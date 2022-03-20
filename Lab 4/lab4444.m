close all;
clc;
clear;
%% 1
Fs=2000;
Fd=500;
t=0:(1/Fs):(1/Fd - 1/Fs);
%% 2
sequence=randi(2,1,1000);
m=[];
for i=1:length(sequence)
    if(sequence(i)==1)
        m(i)=0;
    else
        m(i)=1;
    end
end
%% 3
m(m==0)=-1;
m(m==1)=1;
%% 4
r1=rcosdesign(0,6,length(t),'sqrt');
r2=rcosdesign(0.5,6,length(t),'sqrt');
r3=rcosdesign(1,6,length(t),'sqrt');
tt=linspace(-3/Fd,3/Fd,length(r1));
f=linspace(-Fs/2,Fs/2,length(r1));
r1f=abs(fftshift(fft(r1)))/length(r1);
r2f=abs(fftshift(fft(r2)/length(r2)));
r3f=abs(fftshift(fft(r3)/length(r3)));
figure;
subplot(321);
plot(tt,r1);
subplot(322);
plot(f,r1);
subplot(323);
plot(tt,r2);
subplot(324);
plot(f,r2);
subplot(325);
plot(tt,r3);
subplot(326);
plot(f,r3);



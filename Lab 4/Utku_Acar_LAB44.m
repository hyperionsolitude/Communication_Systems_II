close all;
clc;
clear;
Fs=2000;
Fd=500;
t=0:(1/Fs):(1/Fd - 1/Fs); %tek bir symbol aralýðý
s1=ones(1,length(t));
s0=-1*s1;
pam=[];
for i =1:1000
    m=randi(2)-1;
    if m==1
        pam=[pam s1];
    else
        pam=[pam s0];
    end
end


r_cos1 = rcosdesign(0, 6, length(t));
r_cos2 = rcosdesign(0.5, 6, length(t));
r_cos3 = rcosdesign(1, 6, length(t));
figure(1);
subplot(321);
plot(linspace(-3/Fd,3/Fd,length(r_cos1)),r_cos1);
title('rolloff 0, time domain');
subplot(322);
plot(linspace(-Fs/2, Fs/2, length(r_cos1)), abs(fftshift(fft(r_cos1)))/length(r_cos1));
title('rolloff 0, freq. domain');

subplot(323);
plot(linspace(-3/Fd,3/Fd,length(r_cos2)),r_cos2);
title('rolloff 0.5, time domain');
subplot(324);
plot(linspace(-Fs/2, Fs/2, length(r_cos2)), abs(fftshift(fft(r_cos2)))/length(r_cos2));
title('rolloff 0.5, freq. domain');

subplot(325);
plot(linspace(-3/Fd,3/Fd,length(r_cos3)),r_cos3);
title('rolloff 1, time domain');
subplot(326);
plot(linspace(-Fs/2, Fs/2, length(r_cos3)), abs(fftshift(fft(r_cos3)))/length(r_cos3));
title('rolloff 1, freq. domain');

p=length(t);
tx1 = upfirdn(pam, r_cos1, p);
tx2 = upfirdn(pam, r_cos2, p);
tx3 = upfirdn(pam, r_cos3, p);


b=[1, 0.5, -0.2];
a=[1, 0, 0];

rx1=filter(b,a,tx1);
rx2=filter(b,a,tx2);
rx3=filter(b,a,tx3);


y1=upfirdn(rx1, r_cos1, 1, p);
y2=upfirdn(rx2, r_cos2, 1, p);
y3=upfirdn(rx3, r_cos3, 1, p);

y1=y1(7:length(y1)-6);
y2=y2(7:length(y2)-6);
y3=y3(7:length(y3)-6);

eyediagram(y1, p, 1/Fs, 0);
title('rolloff 0');
eyediagram(y2, p, 1/Fs, 0);
title('rolloff 0.5');
eyediagram(y3, p, 1/Fs, 0);
title('rolloff 1');





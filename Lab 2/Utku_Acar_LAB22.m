close all;
clc;
clear all;
%% modulation
Fs=2000;
t=0:1/Fs:0.05;
ss=1/8;
f1=50;
f2=80;
m = 0.4*sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);

msize=length(m);
mq(1)=0;
for i = 1:msize
    if m(i)>= mq(i)
        mq(i+1) = mq(i)+ss;
        encode(i)=1; %error 1
    else
        mq(i+1) = mq(i)-ss;
        encode(i)=0; %error -1
    end
  
end
%% demod
size_encode=length(encode);
mqd(1)=0;
for i=1:size_encode
    if encode(i) == 1
        mqd(i+1)=mqd(i)+ss;
    else
        mqd(i+1)=mqd(i)-ss;
    end
    decode(i)= mqd(i);

end
cf = 0.1;
n= 100;
b=fir1(n,cf);
out=conv2(decode,b,'same');
figure;
subplot(211);
plot(t,m);
hold on
plot(t,decode);
hold off
subplot(212);
plot(t,out);
hold on
plot(t,m);
hold off
deger=max(40*sin(2*pi*f1.*t)+80*sin(2*pi*f2.*t))/Fs;






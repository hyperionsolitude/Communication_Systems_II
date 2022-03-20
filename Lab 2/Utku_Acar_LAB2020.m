close all;
clc;
clear all;
Fs=2000;
t = 0:1/Fs:0.05;
ss = 1/8;
f1=50;
f2=80;
m = 0.4*sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);

size = length(m);
mq(1) = 0;

for i = 1:size
    if m(i)>= mq(i)
        mq(i+1) = mq(i)+ss;
        encode(i)=1; %error 1
    else
        mq(i+1) = mq(i)-ss;
        encode(i)=0; %error -1
    end
  
end

en_size = length(encode);
mqd(1)=0; 

for i = 1:en_size
    if encode(i) == 1  %not equal 0
        mqd(i+1)=mqd(i)+ss;
        
    else %equal 0
        mqd(i+1)=mqd(i)-ss;
 
    end
end

decode = mqd(1:1:length(t));

cf =0.1;
n=100;
b=fir1(n, cf);
out=conv2(decode,b,'same');

figure(1);
subplot(211);
plot(t,m);
title('ss=1/8');
hold on;
plot(t,decode);
legend('m','decode');
subplot(212);
plot(t,m);
title('ss=1/8');
hold on;
plot(t,out);
legend('m','LPF out');

%%
ss = 1/4;
f1=50;
f2=80;
m = 0.4*sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);

size = length(m);
mq(1) = 0;

for i = 1:size
    if m(i)>= mq(i)
        mq(i+1) = mq(i)+ss;
        encode(i)=1; %error 1
    else
        mq(i+1) = mq(i)-ss;
        encode(i)=0; %error -1
    end
    
end

en_size = length(encode);
mqd(1)=0; 

for i = 1:en_size
    if encode(i) == 1
        mqd(i+1)=mqd(i)+ss;
        
    else
        mqd(i+1)=mqd(i)-ss;
 
    end
end

decode = mqd(1:1:length(t));

cf =0.1;
n=100;
b=fir1(n, cf);
out=conv2(decode,b,'same');

figure(2);
subplot(211);
plot(t,m);
title('ss=1/4');
hold on;
plot(t,decode);
legend('m','decode');
subplot(212);
plot(t,m);
title('ss=1/4');
hold on;
plot(t,out);
legend('m','LPF out');

%%
ss = 1/16;
f1=50;
f2=80;
m = 0.4*sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);

size = length(m);
mq(1) = 0;

for i = 1:size
    if m(i)>= mq(i)
        mq(i+1) = mq(i)+ss;
        encode(i)=1 %error 1
    else
        mq(i+1) = mq(i)-ss;
        encode(i)=0; %error -1
    end
    
end

en_size = length(encode);
mqd(1)=0; 

for i = 1:en_size
    if encode(i) == 1
        mqd(i+1)=mqd(i)+ss;
        
    else
        mqd(i+1)=mqd(i)-ss;
 
    end
end

decode = mqd(1:1:length(t));

cf =0.1;
n=100;
b=fir1(n, cf);
out=conv2(decode,b,'same');

figure(3);
subplot(211);
plot(t,m);
title('ss=1/16');
hold on;
plot(t,decode);
legend('m','decode');
subplot(212);
plot(t,m);
title('ss=1/16');
hold on;
plot(t,out);
legend('m','LPF out');
%%
Fs=2000;
t = 0:1/Fs:0.05;
f1=50;
f2=80;
m = 0.4*sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);
dm = 40*pi*(2*cos(160*pi.*t)+cos(100*pi.*t));


ss = (max(abs(dm)))/Fs;

size = length(m);
mq(1) = 0;

for i=1:size-1
    diff(i) = (m(i+1)-m(i))*Fs;
end

ss1 = max(abs(diff))/Fs;
plot(m);
hold on;
plot(diff);


for i = 1:size
    if m(i)>= mq(i)
        mq(i+1) = mq(i)+ss;
        encode(i)=1 %error 1
    else
        mq(i+1) = mq(i)-ss;
        encode(i)=0 %error -1
    end
    
end

en_size = length(encode);
mqd(1)=0; 

for i = 1:en_size
    if encode(i) == 1  %not equal 0
        mqd(i+1)=mqd(i)+ss;
        
    else %equal 0
        mqd(i+1)=mqd(i)-ss;
 
    end
end

decode = mqd(1:1:length(t));

cf =0.1;
n=100;
b=fir1(n, cf);
out=conv2(decode,b,'same');

figure(4);
subplot(211);
plot(t,m);
title('ss=op');
hold on;
plot(t,decode);
legend('m','decode');
subplot(212);
plot(t,m);
title('ss=op');
hold on;
plot(t,out);
legend('m','LPF out');






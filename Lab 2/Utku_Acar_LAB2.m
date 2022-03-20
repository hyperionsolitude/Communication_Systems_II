close all;
clc;
clear all;
%% 1.a
Am=2;
fm=4;
Fs=80;
t=0:1/Fs:1;
m=Am*cos(2*pi*fm*t);
%% 1.b
%m'=-2*4*Am*pi*max(sin(2*pi*fm*t))-->8*2*pi/Fs-->2*pi/10;
dmin=(2*pi)/10;
%% 1.c
sizem=length(m);
mq(1)=0;
d(1)=dmin;
for i= 1:sizem
    if m(i)>=mq(i)
        mq(i+1)=mq(i)+d(1);
        err(i)=1;
    else
        mq(i+1)=mq(i)-d(1);
        err(i)=-1;
    end
    if err(i)==-1
        encoderout(i)=0;
    else
        encoderout(i)=1;
    end
    
end
%% 1.d
figure;
plot(t,m);
hold on
stairs(t,mq(1:sizem));
xlabel('t');
ylabel('Amplitude');
title('m(t) and mq(t) signals d=2*pi/10 (0.6283)');
legend('m(t)','mq(t)');
hold off 
%% 1.e 
P(1)=(d(1)*d(1)*fm)/(3*Fs);
%% 1.f
mse(1)= mean((m-mq(1:sizem)).^2);
%% 1.g






%% 1.c2
sizem=length(m);
mq1(1)=0;
d(2)=0.2;
for i= 1:sizem
    if m(i)>=mq1(i)
        mq1(i+1)=mq1(i)+d(2);
        err1(i)=1;
    else
        mq1(i+1)=mq1(i)-d(2);
        err1(i)=-1;
    end
    if err1(i)==-1
        encoderout1(i)=0;
    else
        encoderout1(i)=1;
    end
    
end
%% 1.d2
figure;
plot(t,m);
hold on
stairs(t,mq1(1:sizem));
xlabel('t');
ylabel('Amplitude');
title('m(t) and mq1(t) signals d=0.2');
legend('m(t)','mq1(t)');
hold off 
%% 1.e2 
P(2)=(d(2)*d(2)*fm)/(3*Fs);
%% 1.f2
mse(2)= mean((m-mq1(1:sizem)).^2);





%% 1.c3
sizem=length(m);
mq2(1)=0;
d(3)=0.4;
for i= 1:sizem
    if m(i)>=mq2(i)
        mq2(i+1)=mq2(i)+d(3);
        err2(i)=1;
    else
        mq2(i+1)=mq2(i)-d(3);
        err2(i)=-1;
    end
    if err2(i)==-1
        encoderout2(i)=0;
    else
        encoderout2(i)=1;
    end
    
end
%% 1.d3
figure;
plot(t,m);
hold on
stairs(t,mq2(1:sizem));
xlabel('t');
ylabel('Amplitude');
title('m(t) and mq2(t) signals d=0.4');
legend('m(t)','mq2(t)');
hold off 
%% 1.e3 
P(3)=(d(3)*d(3)*fm)/(3*Fs);
%% 1.f3
mse(3)= mean((m-mq2(1:sizem)).^2);






%% 1.c4
sizem=length(m);
mq3(1)=0;
d(4)=1.4;
for i= 1:sizem
    if m(i)>=mq3(i)
        mq3(i+1)=mq3(i)+d(4);
        err3(i)=1;
    else
        mq3(i+1)=mq3(i)-d(4);
        err3(i)=-1;
    end
    if err3(i)==-1
        encoderout3(i)=0;
    else
        encoderout3(i)=1;
    end
    
end
%% 1.d4
figure;
plot(t,m);
hold on
stairs(t,mq3(1:sizem));
xlabel('t');
ylabel('Amplitude');
title('m(t) and mq3(t) signals d=1.4');
legend('m(t)','mq3(t)');
hold off 

%% 1.e4 
P(4)=(d(4)*d(4)*fm)/(3*Fs);
%% 1.f4
mse(4)= mean((m-mq3(1:sizem)).^2);

reconfP=[P(2) P(3) P(1) P(4)];
reconfmse=[mse(2) mse(3) mse(1) mse(4)];
reconfd=[d(2) d(3) d(1) d(4)];
figure;
subplot(211)
plot(reconfd,reconfP);
xlabel('step sizes');
ylabel('Power Values');
title(' Avarage Granular Noise Power');
subplot(212)
plot(reconfd,reconfmse);
xlabel('step sizes');
ylabel('MSE values');
title('MSE');




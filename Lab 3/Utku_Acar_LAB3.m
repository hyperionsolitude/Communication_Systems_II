close all;
clear;
clc;
N=[1 0 0 1 1 0 0 1 0 1];
Fs=1000;
t=0:1/Fs:1-1/Fs;
tb=0:1/Fs:1/length(N)-(1/Fs);
Ts=1/Fs;
s0(1:length(tb))=-1;
s1(1:length(tb))=1;
%% 3.1.d
s=[];
for i=1:length(N)
    if (N(i)==0)
        s=[s s0];
    else
        s=[s s1];
    end
end
%%3.2.b
r15db=awgn(s,15,'measured');
%% 3.3.c
Tb=1/length(N);
Wb=Tb/Ts;
for k=1:length(N)
    tempsum0=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum0 = tempsum0 + sum(r15db(n).*s0(n-(k-1)*Wb));
    end
    r0(k)=tempsum0;
end
for k=1:length(N)
    tempsum1=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum1 = tempsum1 + sum(r15db(n).*s1(n-(k-1)*Wb));
    end
    r1(k)=tempsum1;
end
%% 3.4.a
pe=[];
pemean=[];

% pe=[];
% j=0;
% for i=-15:15
%     rtemp=0;
% 
%     for k=1:100
%         r_temp=awgn(s,i,'measured');
%         pemean = mean(s(1+100*j:100*(j+1))-r_temp(1+100*j:100*(j+1)));
%     end
%     pe=[pe pemean];,
%     j=j+1;
% end
%     %pe=[pe ((s-awgn(s,i,'measured')))];
%     %pemean=mean(pe)
%% 3.4.b
pe1=[];
for i=-15:15
    pe1 =[pe1 qfunc(sqrt(2*(10^(i/10))))];
end


%% 3.5.a 

%% 3.2.b1
r0db=awgn(s,0,'measured');
%% 3.3.c1
Tb=1/length(N);
Wb=Tb/Ts;
for k=1:length(N)
    tempsum0=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum0 = tempsum0 + sum(r0db(n).*s0(n-(k-1)*Wb));
    end
    r01(k)=tempsum0;
end
for k=1:length(N)
    tempsum1=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum1 = tempsum1 + sum(r0db(n).*s1(n-(k-1)*Wb));
    end
    r11(k)=tempsum1;
end

%% 3.2.b2
rn15db=awgn(s,-15,'measured');
%% 3.3.c2
Tb=1/length(N);
Wb=Tb/Ts;
for k=1:length(N)
    tempsum0=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum0 = tempsum0 + sum(rn15db(n).*s0(n-(k-1)*Wb));
    end
    r02(k)=tempsum0;
end
for k=1:length(N)
    tempsum1=0;
    for n=(k-1)*Wb+1:k*Wb
        tempsum1 = tempsum1 + sum(rn15db(n).*s1(n-(k-1)*Wb));
    end
    r12(k)=tempsum1;
end
%% 3.5.b
figure;
subplot(211);
plot(t,s);
xlabel('time(seconds)');
ylabel('Amplitude');
title('s(t)');
subplot(212);
plot(t,r15db);
xlabel('time(seconds)');
ylabel('Amplitude');
title('r(t) 15dB');

figure;
subplot(211);
plot(t,s);
xlabel('time(seconds)');
ylabel('Amplitude');
title('s(t)');
subplot(212);
plot(t,r0db);
xlabel('time(seconds)');
ylabel('Amplitude');
title('r(t) 0dB');

figure;
subplot(211);
plot(t,s);
xlabel('time(seconds)');
ylabel('Amplitude');
title('s(t)');
subplot(212);
plot(t,rn15db);
xlabel('time(seconds)');
ylabel('Amplitude');
title('r(t) -15dB');
%% 3.5.c
figure;
scatter([0:9],r0);
xlabel('Samples');
ylabel('r0(N) values');
title('difference r0(N) and r1(N) in 15dB');
hold on
scatter([0:9],r1);
xlabel('Samples');
ylabel('r1(N) values');
title('difference r0(N) and r1(N) in 15dB');
legend('r0','r1');
hold off


figure;
scatter([0:9],r01);
xlabel('Samples');
ylabel('r0(N) values');
title('difference r0(N) and r1(N) in 0dB');
hold on
scatter([0:9],r12);
xlabel('Samples');
ylabel('r1(N) values');
title('difference r0(N) and r1(N) in 0dB');
legend('r0','r1');
hold off

figure;
scatter([0:9],r02);
xlabel('Samples');
ylabel('r0(N) values');
title('difference r0(N) and r1(N) in -15dB');
hold on
scatter([0:9],r12);
xlabel('Samples');
ylabel('r1(N) values');
title('difference r0(N) and r1(N) in -15dB');
legend('r0','r1');
hold off
%% 3.5.d
r0a=[];
r1a=[];
for i=-15:15
    r=awgn(s,i,'measured');
    for k=1:length(N)
    tempsum0=0;
        for n=(k-1)*Wb+1:k*Wb
            tempsum0 = tempsum0 + sum(r(n).*s0(n-(k-1)*Wb));
        end
        r0(k)=tempsum0;
    end
    for k=1:length(N)
        tempsum1=0;
        for n=(k-1)*Wb+1:k*Wb
            tempsum1 = tempsum1 + sum(r(n).*s1(n-(k-1)*Wb));
        end
        r1(k)=tempsum1;
    end
    r0a=[r0a r0];
    r1a=[r1a r1];
end
rae=[];
for i=0:length(pe1)-1
    for j=0:length(r1)-1
        if(r0a(1+i*10+j)>r1a(1+i*10+j))
            rae(1+i*10+j)=abs(r0a(1+i*10+j)-100);
        else
            rae(1+i*10+j)=abs(r1a(1+i*10+j)-100);
        end
    end
end
% k=[0:9];
% raemean=mean(rae[1+10*k:10*(k+1)]);
raemean=[];
for i=0:30
    raemean=[raemean (mean(rae(1+10*i:10*(i+1))))/100 ];
end
figure;
semilogy([-15:15],pe1);
xlabel('SNR values');
ylabel('Pe values with dB scale');
title('Change in Pe due to SNR changes(dB)');
hold on;
semilogy([-15:15],raemean);
legend('Q funct','Own algorithm');
hold off;
close all
clear
clc
fb=100;
fs=1000;
fc=50;
t=0:1/fs:1-1/fs;
tb=0:1/fb:1-1/fb;
lt=length(t);
ltb=length(tb);
seqlen=lt/ltb;
%% BASK
baskseq=[];
bsa=[];
s0bask=zeros(1,length(tb));
s1bask=cos(2*pi*fc*tb);
for i=1:seqlen
    randnum=randi(2)-1;
    bsa=[bsa randnum];
    if(randnum==0)
        baskseq=[baskseq s0bask];
    else
        baskseq=[baskseq s1bask];
    end
end
%% BFSK
bfskseq=[];
bsf=[];
f0=100;
f1=500;
s0bfsk=sin(2*pi*tb*f0);
s1bfsk=sin(2*pi*tb*f1);
for i=1:seqlen
    bsf=[bsf randnum];
    randnum=randi(2)-1;
    if(randnum==0)
        bfskseq=[bfskseq s0bfsk];
    else
        bfskseq=[bfskseq s1bfsk];
    end
end
%% BPSK
bpskseq=[];
bsq=[];
f2=1000;
theta=pi/4;
s0bpsk=cos(2*pi*tb*f2);
s1bpsk=cos(2*pi*tb*f2+theta);
for i=1:seqlen
    randnum=randi(2)-1;
    bsq=[bsq randnum];
    if(randnum==0)
        bpskseq=[bpskseq s0bpsk];
    else
        bpskseq=[bpskseq s1bpsk];
    end
end
%% Plotting
figure;
plot(t,baskseq);
title('BASK');
xlabel('Time');
ylabel('Amplitude');

figure;
plot(t,bfskseq);
title('BFSK');
xlabel('Time');
ylabel('Amplitude');

figure;
plot(t,bpskseq);
title('BPSK');
xlabel('Time');
ylabel('Amplitude');
%% Demodulation
%% BASK DEMOD
dbsa=[];
for i=1:seqlen
    if(baskseq(ltb*(i-1)+1:ltb*i)==s0bask)
        dbsa=[dbsa 0];
    elseif(baskseq(ltb*(i-1)+1:ltb*i)==s1bask)
        dbsa=[dbsa 1];
    end
end
%% BFSK DEMOD
dbsf=[];
for i=1:seqlen
    if(bfskseq(ltb*(i-1)+1:ltb*i)==s0bfsk)
        dbsf=[dbsf 0];
    elseif(bfskseq(ltb*(i-1)+1:ltb*i)==s1bfsk)
        dbsf=[dbsf 1];
    end
end
%% BPSK DEMOD
dbsp=[];
for i=1:seqlen
    if(bpskseq(ltb*(i-1)+1:ltb*i)==s0bpsk)
        dbsp=[dbsp 0];
    elseif(bpskseq(ltb*(i-1)+1:ltb*i)==s1bpsk)
        dbsp=[dbsp 1];
    end
end
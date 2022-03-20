clear
close all
clc
%% a
b=randi(2,10,1)-1;
fs=45000;
fc=3000;
bitdur=2/1000;
bitlen=fs*bitdur;
Ac=1;
b2=repmat(b,1,bitlen)';
b2=b2(:)';
%% b
t=0:1/fs:0.02-1/fs;
zer=zeros(1,bitdur*fs);
carr=@(t) Ac*cos(2*pi*fc*t);
baskmodulated=[];
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    if(b(i)==0)
        baskmodulated=[baskmodulated zer];
    elseif(b(i)==1)
        baskmodulated=[baskmodulated carr(t1)];
    end

end
bask_demod=[];
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    x_s0=baskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*zer;
    x_s1=baskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*carr(t1);
    x_s0_sum=sum(x_s0);
    x_s1_sum=sum(x_s1);
    difference=x_s1_sum-x_s0_sum;
    if (difference > 0)
        bask_demod=[bask_demod ones(1,90)];
    else
        bask_demod=[bask_demod zeros(1,90)];
    end
end
figure;
subplot(311);
plot(t,b2);
xlabel('Time');
ylabel('Amplitude');
title('Input Bit Sequence');
subplot(312);
plot(t,baskmodulated);
xlabel('Time');
ylabel('Amplitude');
title('BASK Modulated Bit Sequence');
subplot(313);
plot(t,bask_demod);
xlabel('Time');
ylabel('Amplitude');
title('BASK Demodulated Bit Sequence');
%% c
bfskmodulated=[];
f1=3000;
f2=1500;
carrf=@(t,fc) Ac*cos(2*pi*fc*t);
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    if(b(i)==0)
        bfskmodulated=[bfskmodulated carrf(t1,f1)];
    elseif(b(i)==1)
        bfskmodulated=[bfskmodulated carrf(t1,f2)];
    end

end
bfsk_demod=[];
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    x_s0=bfskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*carrf(t1,f1);
    x_s1=bfskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*carrf(t1,f2);
    x_s0_sum=sum(x_s0);
    x_s1_sum=sum(x_s1);
    difference=x_s1_sum-x_s0_sum;
    if (difference > 0)
        bfsk_demod=[bfsk_demod ones(1,90)];
    else
        bfsk_demod=[bfsk_demod zeros(1,90)];
    end
end
figure;
subplot(311);
plot(t,b2);
xlabel('Time');
ylabel('Amplitude');
title('Input Bit Sequence');
subplot(312);
plot(t,bfskmodulated);
xlabel('Time');
ylabel('Amplitude');
title('BFSK Modulated Bit Sequence');
subplot(313);
plot(t,bfsk_demod);
xlabel('Time');
ylabel('Amplitude');
title('BFSK Demodulated Bit Sequence');
%% d
bpskmodulated=[];
M=2; % binary psk
carrp=@(t,m) Ac*cos(2*pi*fc*t + (2*pi*m/(M)));
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    if(b(i)==0)
        bpskmodulated=[bpskmodulated carrp(t1,0)];
    elseif(b(i)==1)
        bpskmodulated=[bpskmodulated carrp(t1,1)];
    end

end
bpsk_demod=[];
for i=1:length(b)
    t1=t(bitdur*fs*(i-1)+1:bitdur*fs*i);
    x_s0=bpskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*carrp(t1,0);
    x_s1=bpskmodulated(bitdur*fs*(i-1)+1:bitdur*fs*i).*carrp(t1,1);
    x_s0_sum=sum(x_s0);
    x_s1_sum=sum(x_s1);
    difference=x_s1_sum-x_s0_sum;
    if (difference > 0)
        bpsk_demod=[bpsk_demod ones(1,90)];
    else
        bpsk_demod=[bpsk_demod zeros(1,90)];
    end
end
figure;
subplot(311);
plot(t,b2);
xlabel('Time');
ylabel('Amplitude');
title('Input Bit Sequence');
subplot(312);
plot(t,bpskmodulated);
xlabel('Time');
ylabel('Amplitude');
title('BPSK Modulated Bit Sequence');
subplot(313);
plot(t,bpsk_demod);
xlabel('Time');
ylabel('Amplitude');
title('BPSK Demodulated Bit Sequence');

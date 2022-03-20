clc;
clear;
fs=1000;
%t=0:1/fs:1;

N=10;
Tb=0.1;
A=1;
t1=0:1/fs:Tb;
s0 = ones(1, length(t1));
s1 = ones(1, length(t1));
s1(1:(length(t1)-1)/2) =A;
s1((length(t1)+1)/2:end) = -A;

%
for i=1:N
    a = randi(2)
    if a == 1
        s((i-1)*(length(t1)-1)+i :i*length(t1)) = s0;
   
    else
        s((i-1)*(length(t1)-1)+i :i*length(t1)) = s1;
    end
    
end
t=linspace(0,1,length(s));
r = awgn(s, 20, 'measured');
Wb=Tb*fs;


for k=1:N
    r0(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s0);
end

for k=1:N
    r1(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s1);
end

figure(1);
subplot(311);
plot(t,s);
title('s(t)');

subplot(312);
plot(t,r);
title('r(t) SNR 20dB');

subplot(313);
scatter([0.01:0.1:1],r0);
hold on;
scatter([0.01:10/100:1],r1);
title('r0[k] and r1[k]');
legend('r0','r1');

%%

r = awgn(s, 0, 'measured');



for k=1:N
    r0(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s0);
end

for k=1:N
    r1(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s1);
end

figure(2);
subplot(311);
plot(t,s);
title('s(t)');

subplot(312);
plot(t,r);
title('r(t) SNR 0dB');

subplot(313);
scatter([0.01:0.1:1],r0);
hold on;
scatter([0.01:10/100:1],r1);
title('r0[k] and r1[k]');
legend('r0','r1');


%%
r = awgn(s, -20, 'measured');



for k=1:N
    r0(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s0);
end

for k=1:N
    r1(k) = sum(r((k-1)*(Wb)+k :k*(Wb+1)).*s1);
end

figure(3);
subplot(311);
plot(t,s);
title('s(t)');

subplot(312);
plot(t,r);
title('r(t) SNR -20dB');

subplot(313);
scatter([0.01:0.1:1],r0);
hold on;
scatter([0.01:10/100:1],r1);
title('r0[k] and r1[k]');
legend('r0','r1');

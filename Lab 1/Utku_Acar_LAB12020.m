close all;
clc;
clear all;

f1 = 1000;
f2=4000;
fs=60000;
n = 0:(1/fs):6*10^-3;
x = 2*sin(2*pi*f1.*n) + sin(2*pi*f2.*n);

y1 = x(1:3:end);
y2 = x(1:9:end);
n1 = n(1:3:end);
n2 = n(1:9:end);

figure(1);
subplot(311);
plot(n, x);
title('x');
xlabel('time');
ylabel('Amplitude');
subplot(312);
plot(n1, y1);
title('y1');
xlabel('time');
ylabel('Amplitude');
subplot(313);
plot(n2, y2);
title('y2');
xlabel('time');
ylabel('Amplitude');

N = length(x);
N1=length(y1);
N2=length(y2);

X = abs(fftshift(fft(x)))/N;
Y1 = abs(fftshift(fft(y1)))/N1;
Y2 = abs(fftshift(fft(y2)))/N2;

fx = linspace(-fs/2, fs/2, N);
fy1 = linspace(-fs/2, fs/2, N1);
fy2 = linspace(-fs/2, fs/2, N2);

figure(2);
subplot(311);
plot(fx, X);
title('X(f)');
xlabel('freq.');
ylabel('Amplitude');
axis([-20000 20000 -inf inf]);
subplot(312);
plot(fy1, Y1);
title('Y1(f)');
xlabel('freq.');
ylabel('Amplitude');
axis([-20000 20000 -inf inf]);
subplot(313);
plot(fy2, Y2);
title('Y2(f)');
xlabel('freq.');
ylabel('Amplitude');

xi1 = interp1(n1, y1, n, 'spline');
xi2 = interp1(n1,y1,n, 'cubic');
xi3 = interp1(n2,y2,n,'spline');
xi4 = interp1(n2,y2,n, 'cubic');

figure(3);
subplot(211);
plot(n, x);
hold on;
plot(n, xi1);
hold on;
plot(n, xi2);
legend('x','linear M=3','cubic M=3');
xlabel('time');
ylabel('Amplitude');
subplot(212);
plot(n, x);
hold on;
plot(n, xi3);
hold on;
plot(n, xi4);
legend('x','linear M=9','cubic M=9');
xlabel('time');
ylabel('Amplitude');


%%
f1=500;
f2=1000;
fs=60000;
t=0:(1/fs):6*10^-3;
x = sin(2*pi*f1.*t) + 0.5*sin(2*pi*f2.*t);
k1=3;%midthread(odd)
k2=5;%midthread(odd)%midrise
xq1 = quantize2_utkuacar(x, k1);
xq2 = quantize2_utkuacar(x, k2);

figure;
subplot(311);
plot(t, x);
hold on;
plot(t, xq1);
legend('x','xq1 k1=3');
xlabel('time');
ylabel('Amplitude');
subplot(312);
plot(t, x);
hold on;
plot(t,xq2);
legend('x','xq2 k2=5');
xlabel('time');
ylabel('Amplitude');
subplot(313);
plot(t, x-xq1);
hold on;
plot(t, x-xq2);
legend('x-xq1 k1=3','x-xq2 k2=5');
xlabel('time');
ylabel('Amplitude');




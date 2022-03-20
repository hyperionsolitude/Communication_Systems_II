clc;
clear all;
close all;
%%
Fs=5000;
n=0:1/Fs:0.2;
x= @(A,f,O) A*sin(2*pi*f*n+O);
A=[1 3 2];
f=[60 20 150];
O=[0,pi/2,pi/4];
xx=x(A(1),f(1),O(1))+x(A(2),f(2),O(2))+x(A(3),f(3),O(3));
figure;
plot(n,xx);
title('Original Signal');
xlabel('n');
ylabel('Amplitude');
%% 1.1.b
xs1=xx(1:10:end);
xs2=xx(1:20:end);
n1=n(1:10:end);
n2=n(1:20:end);
%% 1.1.c
figure;
subplot(211);
stem(n1,xs1);
title('Downsampled by 10');
xlabel('n');
ylabel('Amplitude');
subplot(212);
stem(n2,xs2);
title('Downsampled by 20');
xlabel('n');
ylabel('Amplitude');
%% 1.1.d

%1 I have decided frequency axis respect to specified signal length and using linspace I parsed the axis into equal parts for each signal

%2 To preserve Total Power of the system 

xs1_fft=abs(fftshift(fft(xs1)))/(length(xs1));
xs2_fft=abs(fftshift(fft(xs2)))/(length(xs2));
f11=linspace(-Fs/2,Fs/2,length(xs1));
f22=linspace(-Fs/2,Fs/2,length(xs2));
figure;
subplot(211);
plot(f11,xs1_fft);
title('Downsampled by 10');
xlabel('f');
ylabel('Magnitude');
subplot(212);
plot(f22,xs2_fft);
title('Downsampled by 20');
xlabel('f');
ylabel('Magnitude');
%% 1.1.e
xs1_rcl=interp1(n1,xs1,n,'linear');
xs1_rcc=interp1(n1,xs1,n,'cubic');
xs2_rcl=interp1(n2,xs2,n,'linear');
xs2_rcc=interp1(n2,xs2,n,'cubic');
figure;
plot(n,xx);
hold on;
plot(n,xs1_rcl);
hold on;
plot(n,xs1_rcc);
legend('original', 'linear' ,'cubic' );
title('xs1 reconstruction');
xlabel('n');
ylabel('Amplitude');
figure;
plot(n,xx);
hold on;
plot(n,xs2_rcl);
hold on;
plot(n,xs2_rcc);
legend('original', 'linear' ,'cubic' );
title('xs2 reconstruction');
xlabel('n');
ylabel('Amplitude');
%% 1.2.a 
Fs=5000;
n=0:1/Fs:0.2;
x2= @(A,f,O) A*sin(2*pi*f*n+O);
A1=[5 4 3 2 1];
f1=[50 60 70 80 90];
O1=[0 pi/5 2*pi/5 3*pi/5 4*pi/5];
xx2=x(A1(1),f1(1),O1(1))+x(A1(2),f1(2),O1(2))+x(A1(3),f1(3),O1(3))+x(A1(4),f1(4),O1(4))+x(A1(5),f1(5),O1(5));
figure;
plot(n,xx2);
title('Original Signal');
xlabel('n');
ylabel('Amplitude');
%% 1.2.b
a=min(xx2);
b=max(xx2);
N=[4 8];
xqn=@(x,a,b,N) floor(((x-a)/(b-a))*((2.^N)-1))*((b-a)/((2.^N)-1)) + a;
xq4=xqn(xx2,a,b,N(1));
xq8=xqn(xx2,a,b,N(2));
%% 1.2.c
figure;
subplot(211);
plot(n,xq4);
hold on;
plot(n,xx2);
hold off;
title('Quantized by 4');
xlabel('n');
ylabel('Amplitude');
legend('quantized by 4' ,'original signal');
subplot(212);
plot(n,xq8);
hold on;
plot(n,xx2);
hold off;
title('Quantized by 8');
xlabel('n');
ylabel('Amplitude');
legend('quantized by 4' ,'original signal');
%% 1.2.d
mse4=mean(((xx2-xq4).^2));
mse8=mean(((xx2-xq8).^2));
sqnr4=(mean((xx2).^2))/mse4;
sqnr8=(mean((xx2).^2))/mse8;
sqnr4dB=10*log10(sqnr4);
sqnr8dB=10*log10(sqnr8);

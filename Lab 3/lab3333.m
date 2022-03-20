close all;
clc
clear;
Fs=1000;
N=10;
A=1;
Tb=0.1;
Ts=1/Fs;
t=0:Ts:1-Ts;
s0(find(t==0):find(t==0.1-Ts))=A;
s1(find(t==0):find(t==0.05-Ts))=A;
s1(find(t==0.05):find(t==0.1-Ts))=-A;
s=[];
for i=1:N
    choice= randi(2);
    if(choice==1)
        s=[s s0];
    else
        s=[s s1];
    end
end
r=awgn(s,20,'measured');
Wb=Tb/Ts;
for k=1:N
    temp_sum1=0;
    for n=(k-1)*Wb+1:k*Wb
        temp_sum1=temp_sum1+sum(r(n).*s0(n-(k-1)*Wb));
    end
    r0(k)=temp_sum1;
end
for k=1:N
    temp_sum2=0;
    for n=(k-1)*Wb+1:k*Wb
        temp_sum2=temp_sum2+sum(r(n).*s1(n-(k-1)*Wb));
    end
    r1(k)=temp_sum2;
end
k=1:10;
figure;
subplot(311);
plot(t,s);
subplot(312);
plot(t,r);
subplot(313);
scatter(k,r0);
hold on;
scatter(k,r1);
hold off
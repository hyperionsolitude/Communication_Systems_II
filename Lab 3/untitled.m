clc;
clear;
close all;
%% impulse (hm)
ti=-10:1:10;
imp=zeros(1,21);
imp(12)=1;%impulse at t=1
figure;
stem(ti,imp);
%% unit step (hm)
tu=-10:1:10;
us=zeros(1,length(tu));
for i=1:length(tu)
    if (tu(i)>=0)
        us(i)=1;
    else
        us(i)=0;
    end
end
figure;
stem(tu,us);
%% ramp (hm)
tr=-10:1:10;
r=zeros(1,length(tu));
for i=1:length(tu)
    if (tr(i)>=0)
        r(i)=tr(i);
    else
        r(i)=0;
    end
end
figure;
plot(tr,r);
%% Manipulation and concentination
A=1:10;
Aman=A(1:5);
Acon=[A Aman];

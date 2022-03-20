clc
clear
close all
%% a 
b=[0 0 0 1 1 0 1 1];
Fs=10000;
A=1;
fc=100;
M=4;
bi=0.0125;
t=0:1/Fs:0.1-1/Fs;
psk_modulated=[];
um= @(m,tim) A*cos(2*pi*fc*tim+((2*pi*m)/M));
for m=0:M-1
    tb=t(Fs*bi*m+1:(m+1)*Fs*bi);
    if(b(m*2+1)==0 && b((m+1)*2)==0)
        psk_modulated=[psk_modulated um(0,tb)];
    elseif(b(m*2+1)==0 && b((m+1)*2)==1)
        psk_modulated=[psk_modulated um(1,tb)];
    elseif(b(m*2+1)==1 && b((m+1)*2)==0)
        psk_modulated=[psk_modulated um(2,tb)];        
    elseif(b(m*2+1)==1 && b((m+1)*2)==1)
        psk_modulated=[psk_modulated um(3,tb)];        
    end
end
figure;
plot(t(1:length(psk_modulated)),psk_modulated);
d=[];
for i=1:4
    d=[d bi2de(b(2*(i-1)+1:2*i),'left-msb')];
end
pskmodded=pskmod(d,4);
pskdemodded=pskdemod(pskmodded,4);
bitseq=de2bi(pskdemodded,'left-msb');
scatterplot(pskmodded);
rec_bit=[];
for i=1:length(b)/2
    tb=t(Fs*bi*(i-1)+1:Fs*bi*i);
    mult0=psk_modulated(Fs*bi*(i-1)+1:Fs*bi*i).*um(0,tb);
    mult1=psk_modulated(Fs*bi*(i-1)+1:Fs*bi*i).*um(1,tb);
    mult2=psk_modulated(Fs*bi*(i-1)+1:Fs*bi*i).*um(2,tb);
    mult3=psk_modulated(Fs*bi*(i-1)+1:Fs*bi*i).*um(3,tb);
    sumarry0(i)=sum(mult0);
    sumarry1(i)=sum(mult1);
    sumarry2(i)=sum(mult2);
    sumarry3(i)=sum(mult3);
    comparr=[sumarry0(i) sumarry1(i) sumarry2(i) sumarry3(i)];
    maxx=max(comparr);
    if(maxx == sumarry0(i))
        rec_bit= [rec_bit 0 0];
    elseif(maxx == sumarry1(i))
        rec_bit= [rec_bit 0 1];
    elseif(maxx == sumarry2(i))
        rec_bit= [rec_bit 1 0];
    elseif(maxx == sumarry3(i))
        rec_bit= [rec_bit 1 1];
    end

end
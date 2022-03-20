clc; close all; clearvars;

Fs=50e3;
fc=1e3;
Tb=0.005*Fs;
bit_stream=[ones(1,Tb),zeros(1,Tb),ones(1,Tb),zeros(1,Tb),zeros(1,Tb)]; %[1 0 1 0 0]
inverse_stream=[zeros(1,Tb),ones(1,Tb),zeros(1,Tb),ones(1,Tb),ones(1,Tb)]; %[0 1 0 1 1]
%% BASK MODULATION
t=0:1/(Fs-1):length(bit_stream)/Fs;
x=cos(2*pi*fc*t);
ask_modulated=x.*bit_stream;
%BASK DEMODULATION
for i=1:1:length(ask_modulated)
    if ask_modulated(i)==0
        ask_demodulated(i)=0;
    else
        ask_demodulated(i)=1;
    end
end
%% BFSK MODULATION
fc1=3e3;
x1=cos(2*pi*fc1*t);  
bfsk_modulated=x1.*bit_stream+x.*inverse_stream; 
%BFSK DEMODULATION
for i=1:1:length(bfsk_modulated)
    if bfsk_modulated(i)==x(i)
        bfsk_demodulated(i)=0;
    else
        bfsk_demodulated(i)=1;
    end
end
%% BPSK MODULATION
x2=cos(2*pi*fc*t+pi); 
bpsk_modulated=x.*bit_stream+x2.*inverse_stream;
%BPSK DEMODULATION
for i=1:1:length(bpsk_modulated)
    if bpsk_modulated(i)==x2(i)
        bpsk_demodulated(i)=0;
    else
        bpsk_demodulated(i)=1;
    end
end
%% FIGURES
figure;
subplot(3,1,1);plot(t,bit_stream);
xlabel('t'); ylabel('amplitude'); title('Generated Bitstream');
subplot(3,1,2);plot(t,ask_modulated);
xlabel('t'); ylabel('amplitude'); title('BASK Modulated Signal');
subplot(3,1,3);plot(t,ask_demodulated);
xlabel('t'); ylabel('amplitude'); title('BASK Demodulated Bitstream')
figure;
subplot(3,1,1);plot(t,bit_stream);
xlabel('t'); ylabel('amplitude'); title('Generated Bitstream');
subplot(3,1,2);plot(t,bfsk_modulated);
xlabel('t'); ylabel('amplitude'); title('BFSK Modulated Signal');
subplot(3,1,3);plot(t,bfsk_demodulated);
xlabel('t'); ylabel('amplitude'); title('BFSK Demodulated Bitstream');
figure;
subplot(3,1,1);plot(t,bit_stream);
xlabel('t'); ylabel('amplitude'); title('Generated Bitstream')
subplot(3,1,2);plot(t,bpsk_modulated);
xlabel('t'); ylabel('amplitude'); title('BPSK Modulated Signal');
subplot(3,1,3);plot(t,bpsk_demodulated);
xlabel('t'); ylabel('amplitude'); title('BPSK Demodulated Bitstream');

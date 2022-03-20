%% Preparations
close all;
clc;
clear;
N = 4400;
Repetation = 1000;
SNR_Range = 15;
Inc_Rate=1;
Eb_N0_dB =  [0:Inc_Rate:SNR_Range];
Ec_N0_dB_un = Eb_N0_dB - 10*log10(1);
Ec_N0_dB_74 = Eb_N0_dB - 10*log10(4/7);
Ec_N0_dB_1511 = Eb_N0_dB - 10*log10(11/15);

%% Bit Sequence Generator

bs = bit_seq_gen(N);

%% (7,4) Hamming Code(4 Data 3 Parity)

hamming_encoded_74 = hamming_7_4(N,bs);

%% (15,11) Hamming Code (11 Data 4 Parity)

hamming_encoded_1511 = hamming_15_11(N,bs);

%% Modulation

modded_uncoded = qpsk_mod(bs);
modded_coded_74 = qpsk_mod(hamming_encoded_74);
modded_coded_1511 = qpsk_mod(hamming_encoded_1511);

%% Loop

bit_err_arr_uncoded=[];
bit_err_arr_74=[];
bit_err_arr_1511=[];
for i=1:Repetation
    for k=1:1:length(Eb_N0_dB)

        %% Adding AWGN

        modded_noisy_uncoded = awgn(modded_uncoded,Eb_N0_dB(k),'measured');
        modded_noisy_coded_74 = awgn(modded_coded_74,Eb_N0_dB(k),'measured');
        modded_noisy_coded_1511 = awgn(modded_coded_1511,Eb_N0_dB(k),'measured');        
        
        %% Demodulation
        
        demodded_noisy_uncoded = qpsk_demod(modded_noisy_uncoded);
        demodded_noisy_coded_74 = qpsk_demod(modded_noisy_coded_74);
        demodded_noisy_coded_1511 = qpsk_demod(modded_noisy_coded_1511);
        
        %% Hamming Correction
        
        err_corrected_74 = de_hamming_7_4(demodded_noisy_coded_74);
        err_corrected_1511 = de_hamming_15_11(demodded_noisy_coded_1511);
        
        %% Bit error rate calculation
        
        bit_err_arr_uncoded(i,k)=err_calculator(bs,demodded_noisy_uncoded);
        bit_err_arr_74(i,k)=err_calculator(bs,err_corrected_74);
        bit_err_arr_1511(i,k)=err_calculator(bs,err_corrected_1511);
    end
end

%% Calculating Mean Value of errors for each SNR value

mean_val_uncoded=[];
mean_val_74=[];
mean_val_1511=[];
for i =1:1:length(Eb_N0_dB)
    mean_val_uncoded((i))=mean(bit_err_arr_uncoded(:,i))/length(bs);
    mean_val_74((i))=mean(bit_err_arr_74(:,i))/length(bs);
    mean_val_1511((i))=mean(bit_err_arr_1511(:,i))/length(bs);
end

%% Result Plotting

figure;
semilogy(Ec_N0_dB_un,mean_val_uncoded);
hold on
semilogy(Ec_N0_dB_74,mean_val_74);
hold on
semilogy(Ec_N0_dB_1511,mean_val_1511);
title('Bit Error Rate(BER) of QPSK with Uncoded and Hamming Coded Outputs');
xlabel('Eb/N0(dB)');
ylabel('Bit Error Rate');
legend('Uncoded','(7,4) Hamming coded','(15,11) Hamming coded');
hold off


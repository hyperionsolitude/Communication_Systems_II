%% (15,11) Hamming Code(11 data 4 parity)
function hamming_decoded_1d = de_hamming_15_11(demodded_signal)
    N = length(demodded_signal);
    hamming_decoded_1d = [];
    hamming_decoded_2d = [];
    for i = 1:N/15
        signal_15parsed(i,:) = demodded_signal(15*(i-1)+1:(15*i));
        parity_1_arr(i) = xor(xor(xor(xor(xor(xor(xor(signal_15parsed(i,3),signal_15parsed(i,5)),signal_15parsed(i,7)),signal_15parsed(i,9)),signal_15parsed(i,11)),signal_15parsed(i,13)),signal_15parsed(i,15)),signal_15parsed(i,1));
        parity_2_arr(i) = xor(xor(xor(xor(xor(xor(xor(signal_15parsed(i,3),signal_15parsed(i,6)),signal_15parsed(i,7)),signal_15parsed(i,10)),signal_15parsed(i,11)),signal_15parsed(i,14)),signal_15parsed(i,15)),signal_15parsed(i,2));
        parity_3_arr(i) = xor(xor(xor(xor(xor(xor(xor(signal_15parsed(i,5),signal_15parsed(i,6)),signal_15parsed(i,7)),signal_15parsed(i,12)),signal_15parsed(i,13)),signal_15parsed(i,14)),signal_15parsed(i,15)),signal_15parsed(i,4));
        parity_4_arr(i) = xor(xor(xor(xor(xor(xor(xor(signal_15parsed(i,9),signal_15parsed(i,10)),signal_15parsed(i,11)),signal_15parsed(i,12)),signal_15parsed(i,13)),signal_15parsed(i,14)),signal_15parsed(i,15)),signal_15parsed(i,8));

        errorred_bit = parity_4_arr(i)*8 + parity_3_arr(i)*4 + parity_2_arr(i)*2 + parity_1_arr(i);
        if errorred_bit ~= 0 
            signal_15parsed(i,errorred_bit) = ~signal_15parsed(i,errorred_bit);
        end
        hamming_decoded_2d(i,:) = [signal_15parsed(i,3) signal_15parsed(i,5) signal_15parsed(i,6) signal_15parsed(i,7) signal_15parsed(i,9) signal_15parsed(i,10) signal_15parsed(i,11) signal_15parsed(i,12) signal_15parsed(i,13) signal_15parsed(i,14) signal_15parsed(i,15)];
        hamming_decoded_1d = [hamming_decoded_1d hamming_decoded_2d(i,:)];
    end
end

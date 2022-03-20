%% (7,4) Hamming Code(4 data 3 parity)
function hamming_decoded_1d = de_hamming_7_4(demodded_signal)
    N = length(demodded_signal);
    hamming_decoded_1d = [];
    hamming_decoded_2d = [];
    for i = 1:N/7
        signal_7parsed(i,:) = demodded_signal(7*(i-1)+1:(7*i));
        parity_1_arr(i) = xor(xor(xor(signal_7parsed(i,3),signal_7parsed(i,5)),signal_7parsed(i,7)),signal_7parsed(i,1));
        parity_2_arr(i) = xor(xor(xor(signal_7parsed(i,3),signal_7parsed(i,6)),signal_7parsed(i,7)),signal_7parsed(i,2));
        parity_3_arr(i) = xor(xor(xor(signal_7parsed(i,5),signal_7parsed(i,6)),signal_7parsed(i,7)),signal_7parsed(i,4));
        
        errorred_bit = parity_3_arr(i)*4 + parity_2_arr(i)*2 + parity_1_arr(i);
        if errorred_bit ~= 0
            signal_7parsed(i,errorred_bit) = ~signal_7parsed(i,errorred_bit);
        end
        hamming_decoded_2d(i,:) = [signal_7parsed(i,3) signal_7parsed(i,5) signal_7parsed(i,6) signal_7parsed(i,7)];
        hamming_decoded_1d = [hamming_decoded_1d hamming_decoded_2d(i,:)];
    end
end






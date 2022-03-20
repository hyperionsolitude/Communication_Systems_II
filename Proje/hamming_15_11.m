%% (15,11) Hamming Code(11 data 4 parity)
function hamming_encoded_1d = hamming_15_11(N,bs)
    hamming_encoded_1d = [];
    hamming_encoded_2d = [];
    for i=1:N/11
        bs_11_p(i,:) = bs(11*(i-1)+1:(11*i));
        parity_1_arr(i) = xor(xor(xor(xor(xor(xor(bs_11_p(i,1),bs_11_p(i,2)),bs_11_p(i,4)),bs_11_p(i,5)),bs_11_p(i,7)),bs_11_p(i,9)),bs_11_p(i,11));
        parity_2_arr(i) = xor(xor(xor(xor(xor(xor(bs_11_p(i,1),bs_11_p(i,3)),bs_11_p(i,4)),bs_11_p(i,6)),bs_11_p(i,7)),bs_11_p(i,10)),bs_11_p(i,11));
        parity_3_arr(i) = xor(xor(xor(xor(xor(xor(bs_11_p(i,2),bs_11_p(i,3)),bs_11_p(i,4)),bs_11_p(i,8)),bs_11_p(i,9)),bs_11_p(i,10)),bs_11_p(i,11));
        parity_4_arr(i) = xor(xor(xor(xor(xor(xor(bs_11_p(i,5),bs_11_p(i,6)),bs_11_p(i,7)),bs_11_p(i,8)),bs_11_p(i,9)),bs_11_p(i,10)),bs_11_p(i,11));
        hamming_encoded_2d(i,:) = [parity_1_arr(i) parity_2_arr(i) bs_11_p(i,1) parity_3_arr(i) bs_11_p(i,2) bs_11_p(i,3) bs_11_p(i,4) parity_4_arr(i) bs_11_p(i,5) bs_11_p(i,6) bs_11_p(i,7) bs_11_p(i,8) bs_11_p(i,9) bs_11_p(i,10) bs_11_p(i,11)];
        hamming_encoded_1d = [hamming_encoded_1d hamming_encoded_2d(i,:)];
    end
end
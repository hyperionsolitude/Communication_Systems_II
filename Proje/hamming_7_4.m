%% (7,4) Hamming Code(4 data 3 parity)
function hamming_encoded_1d = hamming_7_4(N,bs)
    hamming_encoded_1d = [];
    hamming_encoded_2d = [];
    for i = 1:N/4
        bs_4parsed(i,:) = bs(4*(i-1)+1:(4*i));
        parity_1_arr(i) = xor(xor(bs_4parsed(i,1),bs_4parsed(i,2)),bs_4parsed(i,4));
        parity_2_arr(i) = xor(xor(bs_4parsed(i,1),bs_4parsed(i,3)),bs_4parsed(i,4));
        parity_3_arr(i) = xor(xor(bs_4parsed(i,2),bs_4parsed(i,3)),bs_4parsed(i,4));
        hamming_encoded_2d(i,:) = [parity_1_arr(i) parity_2_arr(i) bs_4parsed(i,1) parity_3_arr(i) bs_4parsed(i,2) bs_4parsed(i,3) bs_4parsed(i,4)];
        hamming_encoded_1d = [hamming_encoded_1d hamming_encoded_2d(i,:)];
    end
end
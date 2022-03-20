%% Bit Sequence Generator
function bs = bit_seq_gen(N)
    bs = [];
    for i = 0:N-1
        a = randi(2)-1;
        bs = [bs a];
    end
end
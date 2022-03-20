%% Modulation
function m = qpsk_mod(bs)
    m = [];
    N = length(bs);
    for i = 1:(N/2)
        if (bs(2*i-1) == 0) && (bs(2*i) == 0)
            m = [m 0.5+0.5j];
        elseif(bs(2*i-1) == 0) && (bs(2*i) == 1)
            m = [m -0.5+0.5j];
        elseif(bs(2*i-1) == 1) && (bs(2*i) == 1)
            m = [m -0.5-0.5j];
        elseif(bs(2*i-1) == 1) && (bs(2*i) == 0)
            m = [m 0.5-0.5j];
        end
    end
end
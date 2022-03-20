%% Demodulation
function dm = qpsk_demod(m)
    dm=[];
    lenMessage=length(m);
    for i=1:lenMessage
        if (real(m(i)) >= 0 && imag(m(i)) >= 0)
            dm = [dm 0 0];
        elseif(real(m(i)) < 0 && imag(m(i)) >= 0)
            dm = [dm 0 1];
        elseif(real(m(i)) <= 0 && imag(m(i)) < 0)
            dm = [dm 1 1];
        elseif(real(m(i)) >= 0 && imag(m(i)) < 0)
            dm = [dm 1 0];
        end
    end
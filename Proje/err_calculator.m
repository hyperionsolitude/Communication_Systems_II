function counter = err_calculator(bs,  sig)
len = length(bs);
counter = 0;
for i=1:len
    if(bs(i) ~= sig(i))
        counter = counter+1;
    end
end

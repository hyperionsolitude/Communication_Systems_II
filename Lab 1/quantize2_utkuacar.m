function xq = quantize2_utkuacar(x, k)
a = min(x);
b = max(x);
xq = (floor(((x-a)/(b-a))*(2^k - 1)))*((b-a)/(2^k - 1)) + a;

end


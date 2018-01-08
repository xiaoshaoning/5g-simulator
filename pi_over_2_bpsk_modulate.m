function symbols = pi_over_2_bpsk_modulate(input_bits)

one_over_sqrt_2 = 1/sqrt(2);

if bitand(length(input_bits), 1) == 0
    twist_list = repmat([1, 1i], 1, bitshift(length(input_bits), -1));
else
    twist_list = [repmat([1, 1i], 1, bitshift(length(input_bits), -1)), 1];
end

symbols = one_over_sqrt_2 * twist_list .* ((1 - 2*input_bits) + 1i * (1 - 2*input_bits));

end
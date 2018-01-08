function symbols = qpsk_modulate(input_bits)

if bitand(length(input_bits), 1) ~= 0
    error('The number of input bits for qpsk modulation shall be an even number');
end

one_over_sqrt_2 = 1/sqrt(2);

input_bits_reshaped = reshape(input_bits, 2, bitshift(length(input_bits), -1));

symbols = one_over_sqrt_2 * ((1 - 2 * input_bits_reshaped(1, :)) + 1i * (1 - 2 * input_bits_reshaped(2, :)));

end
function symbols = qam256_modulate(input_bits)

if bitand(length(input_bits), 7) ~= 0
    error('The number of input bits for qpsk modulation shall be divisible by 8');
end

one_over_sqrt_170 = 1/sqrt(170);

input_bits_reshaped = reshape(input_bits, 8, bitshift(length(input_bits), -3));

symbols = one_over_sqrt_170 * ((1 - 2 * input_bits_reshaped(1, :)).* (8 - (1 - 2 * input_bits_reshaped(3, :)) .* (4 - (1 - 2 * input_bits_reshaped(5, :)) .* (2 - (1 - 2 * input_bits_reshaped(7, :))))) + ...
    1i * (1 - 2 * input_bits_reshaped(2, :)).* (8 - (1 - 2 * input_bits_reshaped(4, :)) .* (4 - (1 - 2 * input_bits_reshaped(6, :)) .* (2 - (1 - 2 * input_bits_reshaped(8, :))))));

end
function symbols = qam64_modulate(input_bits)

if floor(length(input_bits) / 6) * 6 ~= length(input_bits)
    error('The number of input bits for qpsk modulation shall be divisible by 6');
end

one_over_sqrt_42 = 1/sqrt(42);

input_bits_reshaped = reshape(input_bits, 6, length(input_bits)/6);

symbols = one_over_sqrt_42 * ((1 - 2 * input_bits_reshaped(1, :)).* (4 - (1 - 2 * input_bits_reshaped(3, :)) .* (2 - (1 - 2 * input_bits_reshaped(5, :)))) + ...
    1i * (1 - 2 * input_bits_reshaped(2, :)).* (4 - (1 - 2 * input_bits_reshaped(4, :)) .* (2 - (1 - 2 * input_bits_reshaped(6, :)))));

end
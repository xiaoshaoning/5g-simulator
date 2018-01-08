function symbols = qam16_modulate(input_bits)

if bitand(length(input_bits), 3) ~= 0
    error('The number of input bits for qpsk modulation shall be divisible by 4');
end

one_over_sqrt_10 = 1/sqrt(10);

input_bits_reshaped = reshape(input_bits, 4, bitshift(length(input_bits), -2));

symbols = one_over_sqrt_10 * ((1 - 2 * input_bits_reshaped(1, :)).* (2 - (1 - 2 * input_bits_reshaped(3, :))) + ...
    1i * (1 - 2 * input_bits_reshaped(2, :)) .* (2 - (1 - 2 * input_bits_reshaped(4, :))));

end
function symbols = modulate_map(scrambled_bits, modulation_order)
switch modulation_order
    case 1
        symbols = pi_over_2_bpsk_modulate(scrambled_bits);
    case 2
        symbols = qpsk_modulate(scrambled_bits);
    case 4
        symbols = qam16_modulate(scrambled_bits);
    case 6
        symbols = qam64_modulate(scrambled_bits);
    case 8
        symbols = qam256_modulate(scrambled_bits);
end
end
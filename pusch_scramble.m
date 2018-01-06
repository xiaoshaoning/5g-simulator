% pusch scrambling
% not consider RI, ACK/NACK bits temporarily for the sake of simpilicity

function scrambling_output = pusch_scramble(scrambling_input, n_rnti, n_id)

length_of_input_bits = length(scrambling_input);

c_init = bitshift(n_rnti, 15) + n_id; 

scrambling_code = Gold_sequence_calculate(c_init, length_of_input_bits);

scrambling_output = mod(scrambling_input + scrambling_code, 2);

end
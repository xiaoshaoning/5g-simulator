function rate_matching_output_sequence = bit_selection_implement(encoded_bits, ...
    rate_matching_output_sequence_length, ...
    N_cb, ...
    rv_id, ...
    ldpc_base_graph, ...
    Z_c)

% starting position of different redundancy version
start_position_table = [0, 0; ...
    floor(17 * N_cb/(66 * Z_c)) * Z_c, floor(13 * N_cb/(50 * Z_c)) * Z_c; ...
    floor(33 * N_cb/(66 * Z_c)) * Z_c, floor(25 * N_cb/(50 * Z_c)) * Z_c; ...
    floor(56 * N_cb/(66 * Z_c)) * Z_c, floor(43 * N_cb/(50 * Z_c)) * Z_c];

k_0 = start_position_table(rv_id+1, ldpc_base_graph);

k = 0;
jj = 0;

rate_matching_output_sequence = zeros(1, rate_matching_output_sequence_length);

while k < rate_matching_output_sequence_length
  if encoded_bits(mod(k_0 + jj, N_cb) + 1) ~= -1
      rate_matching_output_sequence(k+1) = encoded_bits(mod(k_0 + jj, N_cb) + 1);
      k = k+1;
  end
  jj = jj+1;
end
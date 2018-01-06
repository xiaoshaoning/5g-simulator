function interleaving_output_sequence = bit_interleave(rate_matching_output_sequence, ...
    rate_matching_output_sequence_lengths, ...
    modulation_order)

E = rate_matching_output_sequence_lengths;
interleaving_output_sequence = zeros(1, E);

switch modulation_order
    case 0
      Q = 1;
    case 1
      Q = 1;
    case 2
      Q = 2;
    case 4
      Q = 4;
    case 6
      Q = 6;
end

for jj = 0:(E/Q-1)
  for ii = 0:(Q-1)    
    interleaving_output_sequence(ii + jj*Q + 1) = rate_matching_output_sequence(ii * E/Q + jj + 1);   
  end
end
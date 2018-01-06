function code_block_concatenated = code_block_concatenate(interleaving_output_sequence, number_of_code_blocks, rate_matching_output_sequence_lengths)

code_block_concatenated = zeros(1, sum(rate_matching_output_sequence_lengths));

start_position = 0;
for r = 0:(number_of_code_blocks-1)
  code_block_concatenated((start_position+1):(start_position+rate_matching_output_sequence_lengths(r+1))) = interleaving_output_sequence{r+1};
  start_position = start_position + rate_matching_output_sequence_lengths(r+1);
end

end
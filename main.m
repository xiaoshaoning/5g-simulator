function main

I_mcs = 20;
pusch_tp = 1;
mcs_table_pusch = '64qam';
mcs_table_pusch_transform_precoding = '64qam';
N_scheduled_symbol = 7;
N_prb_dmrs = 12;
N_prb_overhead = 0;
n_prb = 96;
number_of_layers = 1;
most_recent_configured_tbs = 0;

[modulation_order, target_code_rate] = ulsch_modulation_order_and_target_code_rate(I_mcs, pusch_tp, mcs_table_pusch, mcs_table_pusch_transform_precoding);

transport_block_size = ulsch_transport_block_size_determinate(I_mcs, ...
                                                        modulation_order, ...
                                                        target_code_rate, ...
                                                        pusch_tp, ...
                                                        mcs_table_pusch, ...
                                                        mcs_table_pusch_transform_precoding, ...
                                                        N_scheduled_symbol, ...
                                                        N_prb_dmrs, ...
                                                        N_prb_overhead, ...
                                                        n_prb, ...
                                                        number_of_layers, ...
                                                        most_recent_configured_tbs);

transport_block = randi([0, 1], 1, transport_block_size);

% 3GPP TS 38.212 subclause 6.2.1, transport CRC attachment
if transport_block_size > 3824
  crc_for_tb = crc_for_5g(transport_block, '24A');
else
  crc_for_tb = crc_for_5g(transport_block, '16');
end

transport_block_with_crc = [transport_block, crc_for_tb];

% 3GPP TS 38.212 subclause 6.2.2, LDPC base graph selection
[ldpc_base_graph, parity_check_matrices_protocol] = ldpc_base_graph_select(transport_block_size, target_code_rate);

% 3GPP TS 38.212 subclause 6.2.3, code block segmentation and code block
% CRC attachment. Section 5.2.2
[code_blocks, number_of_code_blocks, K, Z_c] = cb_segment_and_cb_crc_attach(transport_block_with_crc, ldpc_base_graph);

code_block_group_per_tb_info = ones(1, number_of_code_blocks);

G = number_of_code_blocks * K;

encoded_bits = cell(1, number_of_code_blocks);
rate_matching_output_sequence_length = cell(1, number_of_code_blocks);
rate_matching_output_sequence = cell(1, number_of_code_blocks);
interleaving_output_sequence = cell(1, number_of_code_blocks);

for code_block_index = 1:number_of_code_blocks
% 3GPP TS 38.212 subclause 6.2.4, channel coding of UL-SCH, section 5.3.2
  encoded_bits{code_block_index} = ldpc_encode(code_blocks{code_block_index}, ldpc_base_graph, parity_check_matrices_protocol, K, Z_c);

% 3GPP TS 38.212 subclause 6.2.5, rate matching
  rate_matching_output_sequence_length{code_block_index} = bit_selection_calculate(encoded_bits{code_block_index}, ... 
             modulation_order, ...
             G, ...
             number_of_layers, ...
             number_of_code_blocks, ... 
             limited_buffer_rate_match_indicator, ... 
             code_block_group_per_tb_info);
         
  rate_matching_output_sequence{code_block_index} = bit_selection_implement(encoded_bits{code_block_index}, ...
                                                                            rate_matching_output_sequence_length{code_block_index});

  interleaving_output_sequence{code_block_index} = bit_interleaving(rate_matching_output_sequence{code_block_index}, ...
                                                                    rate_matching_output_sequence_length{code_block_index}, ...
                                                                    modulation_order);                                                                       
end

% 3GPP TS 38.212 subclause 6.2.6, code block concatenation


% 3GPP TS 38.212 subclause 6.2.7, data and control multiplexing


end % end of main
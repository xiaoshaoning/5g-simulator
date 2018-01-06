function [rate_matching_output_sequence_lengths, N_cb] = bit_selection_calculate(modulation_order, ...
    N, ...
    G, ...
    number_of_layers, ...
    number_of_code_blocks, ...
    limited_buffer_rate_match_indicator, ...
    code_block_group_per_tb_info, ...
    code_block_group_per_tb_info_enabled)

if limited_buffer_rate_match_indicator == 0
    N_cb = N;
else
    R_lbrm = 2/3;
    max_number_of_layers = 2;
    max_modulation_order = 6;
    max_number_of_prbs = 100;
    tbs_lbrm = tbs_lbrm_determinate(max_number_of_layers, max_modulation_order, max_number_of_prbs);
    N_ref = floor(tbs_lbrm/(number_of_code_blocks * R_lbrm));
    N_cb = min([N, N_ref]);
end

rate_matching_output_sequence_lengths = zeros(1, number_of_code_blocks);

if code_block_group_per_tb_info_enabled == 1
    C_prime = sum(code_block_group_per_tb_info);
else
    C_prime = number_of_code_blocks;
end

jj = 0;
for r = 0:(number_of_code_blocks - 1)
    if code_block_group_per_tb_info(r+1) == 0 && code_block_group_per_tb_info_enabled == 1
        rate_matching_output_sequence_lengths(r+1) = 0;
    else
        if jj <= C_prime - mod(G/(number_of_layers * modulation_order), C_prime) - 1
            rate_matching_output_sequence_lengths(r+1) = number_of_layers * modulation_order * floor(G/(number_of_layers * modulation_order * C_prime));
        else
            rate_matching_output_sequence_lengths(r+1) = number_of_layers * modulation_order * ceil(G/(number_of_layers * modulation_order * C_prime));
        end
    end
end
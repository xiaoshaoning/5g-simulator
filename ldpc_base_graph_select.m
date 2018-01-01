function [ldpc_base_graph, parity_check_matrices_protocol] = ldpc_base_graph_select(transport_block_size, target_code_rate)

if transport_block_size <= 292 || ...
     (transport_block_size <= 3824 && target_code_rate <= 0.67) || ...
     target_code_rate <= 0.25
  ldpc_base_graph = 2;
  load parity_check_matrices_protocol_2
  parity_check_matrices_protocol = parity_check_matrices_protocol_2;
else
  ldpc_base_graph = 1;
  load parity_check_matrices_protocol_1
  parity_check_matrices_protocol = parity_check_matrices_protocol_1;
end
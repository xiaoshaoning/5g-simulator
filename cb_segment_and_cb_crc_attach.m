function [code_blocks, number_of_code_blocks, K, Z_c, N] = cb_segment_and_cb_crc_attach(transport_block_with_crc, ldpc_base_graph)

B = length(transport_block_with_crc);

if ldpc_base_graph == 1
  K_cb = 8448;
elseif ldpc_base_graph == 2
  K_cb = 3824;
end

if B <= K_cb
  L = 0;
  C = 1;
  B_prime = B;
else
  L = 24;
  C = ceil(B/(K_cb - L));
  B_prime = B + C * L;
end

code_blocks = cell(1, C);

K_prime = B_prime / C;

if ldpc_base_graph == 1
  K_b = 22;
elseif ldpc_base_graph == 2
  if B > 640
    K_b = 10;
  elseif B > 560
    K_b = 9;
  elseif B > 192
    K_b = 8;
  else
    K_b = 6;
  end
end

Z_c = find_the_minimum_value_of_Z(K_b, K_prime);

if ldpc_base_graph == 1
  K = 22 * Z_c;
  N = 66 * Z_c;
else
  K = 10 * Z_c;
  N = 50 * Z_c;
end

s = 0;
for r = 0:(C-1)
  
  tmp = -1 * ones(1, K); % -1 represents NULL
  
  for k = 0:(K_prime - L - 1)
    tmp(k+1) = transport_block_with_crc(s+1);
    s = s+1;
  end
  
  if C > 1
    crc_for_cb = crc_for_5g(tmp(1:(K_prime-L)), '24B');
    tmp((K_prime-L+1):K_prime) = crc_for_cb;
  end
  
  code_blocks{r+1} = tmp;
end    

number_of_code_blocks = C;

end
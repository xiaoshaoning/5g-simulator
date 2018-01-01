% PUSCH transport block size determinatation
% according to 3GPP Release 15, TS 38.214 v2.0.0 subclause 6.1.4.2
% @author: Xiao, Shaoning
% @email: xiaoshaoning@foxmail.com
% @date: 2018-01-01

function transport_block_size = ulsch_transport_block_size_determinate(I_mcs, ...
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
                                                                 most_recent_configured_tbs)
N_prb_sc = 12;

if ((I_mcs <=27) && (pusch_tp == 0) && strcmpi(mcs_table_pusch, '256qam')) || ...
      ((I_mcs <=27) && (pusch_tp == 1) && strcmpi(mcs_table_pusch_transform_precoding, '256qam')) || ...
      ((I_mcs <=28) && (pusch_tp == 0) && ~strcmpi(mcs_table_pusch, '256qam')) || ...
      ((I_mcs <=27) && (pusch_tp == 1) && ~strcmpi(mcs_table_pusch_transform_precoding, '256qam'))
  
  N_re_prime = N_prb_sc * N_scheduled_symbol - N_prb_dmrs - N_prb_overhead;
  
  % quantized number of REs allocated for PUSCH within a PRB
  N_re_prime_bar = quantized_number_of_resource_elements_for_pdsch_within_a_prb(N_re_prime);
  
  N_re = N_re_prime_bar * n_prb;
  
  % steps 2-5 defined in subclause 5.1.3.2
  N_info = N_re * target_code_rate * modulation_order * number_of_layers;
  
  if N_info <= 3824
    % step 3
    n = max(3, floor(log2(N_info)) - 6);
    
    N_info_prime = max(24, 2^n * floor(N_info/(2^n)));
    
    % use table 5.1.3.2-2
    tbs_table = tbs_table_for_N_info_less_than_3824;
    tbs_list = tbs_table(tbs_table > N_info_prime);
    transport_block_size = tbs_list(1);
    
  else
    % step 4
    n = floor(log2(N_info - 24)) - 5;
    N_info_prime = 2^n * round((N_info - 24) / (2^n));
    
    if target_code_rate <= 1/4
      C = ceil((N_info_prime + 24) / 3816);
      transport_block_size = 8 * C * ceil((N_info_prime + 24) / (8*C)) - 24;
    else
      if N_info_prime > 8424
        C = ceil((N_info_prime + 24) / 8424);
        transport_block_size = 8 * C * ceil((N_info_prime + 24) / (8*C)) - 24;  
      else
        transport_block_size = 8 * ceil((N_info_prime + 24) / 8) - 24;          
      end
    end    
  end % end of if N_info <= 3824
  
elseif (I_mcs >= 28 && I_mcs <= 31 && pusch_tp == 0 && strcmpi(mcs_table_pusch, '256qam')) || ...
       (I_mcs >= 28 && I_mcs <= 31 && pusch_tp == 1 && strcmpi(mcs_table_pusch_transform_precoding, '256qam')) || ...
       (I_mcs >= 28 && I_mcs <= 31 && pusch_tp == 1 && ~strcmpi(mcs_table_pusch_transform_precoding, '256qam'))   
 transport_block_size = most_recent_configured_tbs;
else
 transport_block_size = most_recent_configured_tbs;     
end
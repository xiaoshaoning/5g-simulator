% PUSCH modulation order and target code determinatation
% according to 3GPP Release 15, TS 38.214 v2.0.0 subclause 6.1.4.1
% @author: Xiao, Shaoning
% @email: xiaoshaoning@foxmail.com
% @date: 2018-01-01

function [modulation_order, target_code_rate] = ulsch_modulation_order_and_target_code_rate(I_mcs, pusch_tp, mcs_table_pusch, mcs_table_pusch_transform_precoding)

if pusch_tp == 0  && ~strcmpi(mcs_table_pusch, '256qam') % pusch_tp is disabled, mcs_table_pusch is not set to 256QAM
  % table 5.1.3.1-1
  mcs_index_table = table_51311;
elseif pusch_tp == 0 && strcmpi(mcs_table_pusch, '256qam')
  % table 5.1.3.1-2  
  mcs_index_table = table_51312;
elseif pusch_tp == 1 && ~strcmpi(mcs_table_pusch_transform_precoding, '256qam')
  % table 6.1.4.1-1  
  mcs_index_table = table_61411;  
else
  % table 5.1.3.1-2
  mcs_index_table = table_51312;  
end

modulation_order = mcs_index_table(I_mcs+1, 1);
target_code_rate = mcs_index_table(I_mcs+1, 2) / 1024;

end
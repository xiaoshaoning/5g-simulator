function N_re_prime_bar = quantized_number_of_resource_elements_for_pdsch_within_a_prb(N_re_prime)

if N_re_prime <= 9
  N_re_prime_bar = 6;
elseif N_re_prime <= 15
  N_re_prime_bar = 12;
elseif N_re_prime <= 30
  N_re_prime_bar = 18;
elseif N_re_prime <= 57
  N_re_prime_bar = 42;
elseif N_re_prime <= 90
  N_re_prime_bar = 72;
elseif N_re_prime <= 126
  N_re_prime_bar = 108;
elseif N_re_prime <= 150
  N_re_prime_bar = 144;
elseif N_re_prime > 150
  N_re_prime_bar = 156;
end

end
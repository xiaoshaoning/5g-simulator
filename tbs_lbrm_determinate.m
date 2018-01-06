function tbs_lbrm = tbs_lbrm_determinate(max_number_of_layers, max_modulation_order, max_number_of_prbs)

R_lbrm = 2/3;

N_re_prime_bar = 156;

N_re = N_re_prime_bar * max_number_of_prbs;

% steps 2-5 defined in subclause 5.1.3.2
N_info = N_re * R_lbrm * max_modulation_order * max_number_of_layers;

if N_info <= 3824
    % step 3
    n = max(3, floor(log2(N_info)) - 6);
    
    N_info_prime = max(24, 2^n * floor(N_info/(2^n)));
    
    % use table 5.1.3.2-2
    tbs_table = tbs_table_for_N_info_less_than_3824;
    tbs_list = tbs_table(tbs_table > N_info_prime);
    tbs_lbrm = tbs_list(1);
    
else
    % step 4
    n = floor(log2(N_info - 24)) - 5;
    N_info_prime = 2^n * round((N_info - 24) / (2^n));
    
    if R_lbrm <= 1/4
        C = ceil((N_info_prime + 24) / 3816);
        tbs_lbrm = 8 * C * ceil((N_info_prime + 24) / (8*C)) - 24;
    else
        if N_info_prime > 8424
            C = ceil((N_info_prime + 24) / 8424);
            tbs_lbrm = 8 * C * ceil((N_info_prime + 24) / (8*C)) - 24;
        else
            tbs_lbrm = 8 * ceil((N_info_prime + 24) / 8) - 24;
        end
    end
end % end of if N_info <= 3824

end
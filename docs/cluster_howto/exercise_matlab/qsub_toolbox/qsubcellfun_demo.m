% array dimension
n_array = {10, 10, 10, 10, 10};

% duration of the computation
t_array = {100, 100, 100, 100, 100};

% translate array dimension into job memory requirement 
req_mem   = 10 * 10 * 8;

% translate duration of the computation into job walltime requirement 
req_etime = 100;

% call qsubcellfun to distribute the computations by running 5 jobs in parallel
%out = qsubcellfun(@randn_aft_t,  n_array,  t_array,  'memreq',  req_mem,  'timreq',  req_etime)
out = qsubcellfun(@randn_aft_t,  n_array,  t_array,  'memreq',  req_mem,  'timreq',  req_etime, 'options', '-V')

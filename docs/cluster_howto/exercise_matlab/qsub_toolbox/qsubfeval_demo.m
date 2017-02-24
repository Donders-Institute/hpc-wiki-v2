% array dimension
n_array = {2, 4, 6, 8, 10};

% duration of the computation
t_array = {20, 40, 60, 80, 100};

jobs = {};

for i = 1:5
    % translate array dimension into job memory requirement 
    req_mem   = n_array{i} * n_array{i} * 8;

    % translate duration of the computation into job walltime requirement 
    req_etime = t_array{i};

    % call qsubfevl to submit a job individually with a different resource requirement 
    jobs{i} = qsubfeval(@randn_aft_t,  n_array{i},  t_array{i},  'memreq',  req_mem,  'timreq',  req_etime);
end

save 'jobs.mat' jobs

% load job id list created by qsubfeval_demo.m 
load 'jobs.mat'

out = {};
% retrieve output from each job
for j = jobs 
    out = [out, qsubget( j{:} )];
end

out

load 'jobs.mat'
for j = jobs
    jid = qsublist('getpbsid', j);
    cmd = sprintf('qstat %s', jid);
    unix(cmd);
end

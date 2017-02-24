function y = randn_aft_t(n, t)

stopwatch = tic;
while (toc(stopwatch)<t)
y = randn(n);
end

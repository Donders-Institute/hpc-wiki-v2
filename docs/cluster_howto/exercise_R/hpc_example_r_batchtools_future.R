library(future)
library(future.apply)
library(future.batchtools)

# Exercise 1: submit jobs to cluster via future
plan(batchtools_slurm, resources = list(walltime = '00:05:00', memory = '2Gb')) # specify that the PBS Torque cluster is used and the resources we want

get_random_mean <- function(mu){ # a simple example function
  mean(rnorm(100, mean = mu))
}

single_result %<-% get_random_mean(50) # submit a single job
single_result # wait until the job is finished and print the result

res <- future_sapply(40:60, get_random_mean) # future_*apply functions are analogous to *apply functions in base R but are executed through future, meaning that they can run in parallel

resolve(res) # wait for the results

# Example 2: submit many jobs in parallel via batchtools

library(batchtools)
reg <- makeRegistry(file.dir = '.batch_registry', seed = 1) # creates a folder for a registry with all neccessary bookkeeping info

reg$cluster.functions <- makeClusterFunctionsSlurm(template = "slurm") # use HPC
# reg$cluster.functions = makeClusterFunctionsMulticore(4) # if you are trying this at home, you can also use Multicore instead of Torque to run the example at your own PC
reg$default.resources = list(mem='2Gb', time='00:10:00', ncpus=1)

get_random_mean2 <- function(mu, sigma, ...){ # a slightly more complicated example function
  mean(rnorm(100, mean = mu, sd = sigma))
}

par_grid <- expand.grid(mu = -5:5, sigma = seq(3, 33, 10), nrep = 1:100) # create a parameter grid
jobs <- batchMap(get_random_mean2, par_grid) # write jobs in the registry
jobs$chunk <- chunk(jobs$job.id, chunk.size = 1000) # combine jobs in 1000-jobs chunks for the cluster

submitJobs(jobs) # send jobs

waitForJobs() # wait for the jobs to complete
res <- reduceResultsDataTable()
res <- cbind(par_grid, res) # combine with the job parameters
head(res) # print first results

removeRegistry() # clean up


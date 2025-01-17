# Title     : Example of how to run brms in parallel on the cluster
# Created by: Andrey Chetverikov
# Created on: 15/11/2021, adjusted for slurm on 16/01/2024 by Jan-Mathijs Schoffelen
#
# This script assumes that you have a valid batchtools.slurm.tmpl template in the working directory (or .batchtools.slurm.tmpl in your home directory)
# This example is based on the "eight schools" example from the brm helpfile

library(future)
library(future.batchtools)
library(brms)

p <- read.csv("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv") # load the data
p <- within(p, { # set the important variables to factors
  prog <- factor(prog, levels=1:3, labels=c("General", "Academic",
                                            "Vocational"))
  id <- factor(id)
})

# create a parallelization plan for future
plan(list(
  tweak(batchtools_slurm, resources = list(time = '00:20:00', mem = '6Gb', ncpus = 1, packages = c('brms'))), # first jobs are submitted for 20 minutes
  tweak(batchtools_slurm, resources = list(time = '00:05:00', mem = '6Gb', ncpus = 1, packages = c('brms')))  # the jobs created within these jobs are set to run with 5-minute limit
), .cleanup = T) # two-level paralellization setup to compile on the cluster and then run the chains in parallel


brm_job <- future({ # brm model is compiled and ran within the future, meaning that a job is created at the cluster for this
  brm(num_awards~math+prog, data = p, family = 'poisson', future = T) # setting a future parameter to true tells brms to use future to parallelize the chains
}) # the job is submitted to compile on the cluster and the individual chains are in turn started in parallel

while (!resolved(brm_job)) Sys.sleep(5) # wait until the job is finished

brm_val <- value(brm_job) # load the results
brm_val


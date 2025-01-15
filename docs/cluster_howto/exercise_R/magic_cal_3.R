tdir <- tempdir()
.libPaths(tdir)

# check if the magic library is among the installed packages
hasmagic    <- c("magic") %in% rownames(installed.packages())

# if not then install it in a temporary directory (which has been added to the library path)
if (hasmagic==FALSE)    {install.packages("magic",   lib=tdir, dependencies=TRUE, repos="https://cran.r-project.org")}

# load libraries 
library("magic")

# load utility from /opt/cluster/share/R
source("/opt/cluster/share/R/utility.r")

# get script name and arguments
rcmd <- parse_arguments()

# get job info for bookkeeping
jinfo <- get_bookkeep_info(rcmd$script)

# run analysis, and save object on-demand
magic_matrix <- magic(as.integer(rcmd$args[1]))
save_objects(c("magic_matrix"), path=NA, job_bookkeep_info=jinfo, append=TRUE)

sum_diagonal <- sum(diag(magic_matrix))
save_objects(c("sum_diagonal"), path=NA, job_bookkeep_info=jinfo, append=TRUE)


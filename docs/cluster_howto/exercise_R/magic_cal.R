tdir <- tempdir()
.libPaths(tdir)

# check if the magic library is among the installed packages
hasmagic    <- c("magic") %in% rownames(installed.packages())

# if not then install it in a temporary directory (which has been added to the library path)
if (hasmagic==FALSE)    {install.packages("magic",   lib=tdir, dependencies=TRUE, repos="https://cran.r-project.org")}

# load library
library("magic")

# get script name and arguments
args <- commandArgs(TRUE)

# run analysis
magic_matrix <- magic(as.integer(args[1]))
sum_diagonal <- sum(diag(magic_matrix))

print(magic_matrix)
print(sum_diagonal)

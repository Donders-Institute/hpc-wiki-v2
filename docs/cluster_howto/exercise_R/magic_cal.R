# load libraries 
library("magic")

# get script name and arguments
args <- commandArgs(TRUE)

# run analysis
magic_matrix <- magic(as.integer(args[1]))
sum_diagonal <- sum(diag(magic_matrix))

print(magic_matrix)
print(sum_diagonal)

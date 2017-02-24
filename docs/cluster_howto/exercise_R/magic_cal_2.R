# load libraries 
library("magic")

# utility function to retrive data for job bookkeeping
#
# [Input]
#  - default_jobname: the string used as job name, if
#                     PBS_JOBNAME is not available.
# [Output]
#  - workdir: the directory in which the script runs 
#  - jobid  : Torque job id or the system process id
#  - jobname: Torque job name or the given jobname
get_bookkeep_info <- function(default_jobname="") {

    ## resolve workdir (PWD directory, or PBS_O_WORKDIR)
    wdir <- Sys.getenv("PWD") 
    if ( Sys.getenv("PBS_O_WORKDIR") != "" ) wdir <- Sys.getenv("PBS_O_WORKDIR")

    ## resolve job/process identifier (process id $$ or PBS_JOBID
    jid <- system("echo $$", intern=TRUE)[1]
    if ( Sys.getenv("PBS_JOBID") != "" ) jid <- unlist(strsplit(Sys.getenv("PBS_JOBID"), ".", fixed=TRUE))[1]

    ## resolve job name (caller function or PBS_JOBNAME)
    jname <- default_jobname 
    if ( Sys.getenv("PBS_JOBNAME") != "" ) jname <- unlist(strsplit(Sys.getenv("PBS_JOBNAME"), ".", fixed=TRUE))[1]

    info <- list("workdir"=wdir, "jobid"=jid, "jobname"=jname)

    return(info)
}

# utility function to parse Rscript command-line argument to get
#
# [Output]
#  - script: name of the current R script
#  - args  : arguments provided to the current R script
parse_arguments <- function() {
    args <- commandArgs(FALSE)
    sname <- sub("--file=", "", args[grep("--file=", args)])
    if ( match("--args", args, nomatch=-1) != -1 ) {
        args <- args[match("--args",args)+1:length(args)]
    }
    return(list("script"=sname,"args"=args))
}

# utility function to save R objects in .RData file
#
# [Input]
#  - objects: a character vector containing object names to be saved to the .RData file
#  - path: the path of the file in which the objects will be saved 
#  - job_bookkeep_info: the job bookkeeping info list by which the path of the file is 
#                       constructed.
#  - append: TRUE for appending objects to the file
#
#  One of "path" and "job_bookkeep_info" is required. 
#
# [Output]
#  - script: name of the current R script
#  - args  : arguments provided to the current R script
save_objects <- function(objects, path=NA, job_bookkeep_info=NA, append=FALSE) {

    if ( ! is.na(job_bookkeep_info)) {
        outfile <- paste(job_bookkeep_info$jobname, paste('r', job_bookkeep_info$jobid, sep=""), "RData", sep=".")
        path <- file.path(job_bookkeep_info$workdir, outfile)
    }

    if ( is.na(path) ) {
        stop("output file path not specified")
    } else {

        if ( file.exists(path) && append ) {
            cat("appending objects ", paste0(objects, collapse=","), " to ", path, " ...")
            # load existing object in environment "o"
            load(path, envir=o<-new.env())
            # overwritting/adding object in "o"
            for ( obj in objects) {
                assign(obj, get(obj), envir=o)
            }
            # saving objects in environment "o"
            save(list=ls(o), envir=o, file=path)
            cat("done\n")
        } else {
            cat("saving objects ", paste0(objects, collapse=","), " to ", path, " ...")
            save(list=objects, file=path)
            cat("done\n")
        }
    }
} 

# get script name and arguments
rcmd <- parse_arguments()

# get job info for bookkeeping
jinfo <- get_bookkeep_info(rcmd$script)

# run analysis
magic_matrix <- magic(as.integer(rcmd$args[1]))
sum_diagonal <- sum(diag(magic_matrix))

# save data objects to output file
save_objects(c("magic_matrix","sum_diagonal"), path='magic_cal_2.out.RData', job_bookkeep_info=NA)

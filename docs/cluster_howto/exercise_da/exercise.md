# Exercise: distribute data analysis in the Torque cluster

This exercise mimics a distributed data analysis assuming that we have to apply the same data analysis algorithm independently on the datasets collected from 5 subjects.  We will use the torque cluster to run the analysis in parallel.

## Preparation

Using the commands below to download the exercise package from [this link](torque_exercise.tgz) and check its content.

```bash
$ wget http://donders-institute.github.io/hpc-wiki/en/cluster_howto/exercise_da/torque_exercise.tgz
$ tar xvzf torque_exercise.tgz
$ cd torque_exercise
$ ls
run_analysis.sh  subject_1  subject_2  subject_3  subject_4  subject_5
```

In the package, there are folders for subject data (i.e. `subject_{1..5}`).  In each subject folder, there is a data file containing an encrypted string (URL) pointing to the subject's photo.  In this fake analysis, we are going to find out who our subjects are by decrypting the string and downloading the photo into each subject's folder.  You will find the analysis script in the folder, and it is called `run_analysis.sh`.

The analysis script is written in bash language.

## Task
1. (optional) read the script `run_analysis.sh` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

    Hint: the script consists of a bash _function_ encapsulating the data-analysis algorithm. The function takes one input argument, the subject id. In the main program (the last line), the function is called with an input `$1`.  In bash, variable `$1` is used to refer to the first argument of a shell command.

2. run the analysis by submitting 5 parallel jobs; each runs on a dataset.

    Hint: The command `seq 1 N` is useful for generating a list of integers between 1 and N. You could also use `{1..N}` as an alternative.

3. wait until the jobs finish and check out who our subjects are. You should see a file `photo.*` in each subject's folder.
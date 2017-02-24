# Solution for Exercise: distribute data analysis in the Torque cluster

1. a complete version of the `run_analysis.sh`: 

   [gimmick:gist](4c1fe3dbdd50e21be399)

2. submit jobs to the torque cluster

   ```bash
   $ for id in $( seq 1 5 ); do echo "$PWD/run_analysis.sh $id" | qsub -N "subject_$id" -q veryshort; done
   ```

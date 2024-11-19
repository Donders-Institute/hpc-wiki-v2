#. a complete version of the ``run_analysis.sh``:

   .. code-block:: bash
       :linenos:

       #!/bin/bash

       ## This function mimicing data analysis on subject dataset.
       ##   - It takes subject id as argument.
       ##   - It decrypts the data file containing an encrypted URL to the subject's photo.
       ##   - It downloads the photo of the subject.
       ##
       ## To call this function, use
       ##
       ##   analyze_subject_data <the_subject_id>
       function analyze_subject_data {

           ## get subject id from the argument of the function
           id=$1

           ## determin the root directory of the subject folders
           if [ -z $SUBJECT_DIR_ROOT ]; then
               SUBJECT_DIR_ROOT=$PWD
           fi

           subject_data="${SUBJECT_DIR_ROOT}/subject_${id}/data"

           ## data decryption password
           decrypt_passwd="dccn_hpc_tutorial"

           if [ -f $subject_data ]; then

               ## decrypt the data and get URL to the subject's photo
               url=$( openssl enc -aes-256-cbc -d -in $subject_data -pbkdf2 -k $decrypt_passwd )

               if [ $? == 0 ]; then

                   ## get the file suffix of the photo file
                   ext=$( echo $url | awk -F '.' '{print $NF}' )

                   ## download the subject's photo
                   wget --no-check-certificate $url -o ${SUBJECT_DIR_ROOT}/subject_${id}/log -O ${SUBJECT_DIR_ROOT}/subject_${id}/photo.${ext}

                   return 0

               else
                  echo "cannot resolve subject data url: $subject_data"
                  return 1
               fi

           else
               echo "data file not found: $subject_data"
               return 2
           fi
       }

       ## The main program starts here
       ##  - make this script to take the subject id as its first command-line argument
       ##  - call the data analysis function given above with the subject id as the argument

       analyze_subject_data $1

#. submit jobs to the slurm cluster

   .. code-block:: bash

       $ for id in $( seq 1 5 ); do sbatch --job-name=subj_${id} --time=10:00 --mem=4gb $PWD/run_analysis.sh $id; done

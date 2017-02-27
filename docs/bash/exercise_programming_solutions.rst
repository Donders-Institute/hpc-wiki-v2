.. _bash_exercise_programming_t5_q2:

Task 5 question 2
-----------------

.. code-block:: bash

    $ grep "run-time" $file | grep -o " [0-9]\." | grep -o "[0-9]"

.. _bash_exercise_programming_t5_q4:

Task 5 question 4
-----------------

.. code-block:: bash

    for file in *log; do
        var=$(grep "run-time" $file | grep -o " [0-9]\." | grep -o "[0-9]")
        if [[ $var -lt 9 ]]; then
            echo "$file : $var"
        fi
    done

.. _bash_exercise_programming_t5_q5:

Task 5 question 5
-----------------

.. code-block:: bash

    for file in *log; do
        var=$(grep "run-time" $file | grep -o " [0-9]\." | grep -o "[0-9]")
        if [[ $var -lt 9 && $var -gt 0 ]]; then
            echo "$file : $var"
        fi
    done

.. _genai_ollama:

Ollama
******

`Ollama <https://ollama.com>`__ is an open-source GenAI engine for running the large-language models built upon `Llama <https://llama.com>`__.  It offers an opportunity to run GenAI engine on-premises to avoid data security and privacy concerns with Cloud-based engines.

This guide will show you how to run an ollama server on the HPC cluster serving the `codellama <https://ai.meta.com/blog/code-llama-large-language-model-coding/>`__ model, and use it as a coding assisstent.

Running Ollama server with a slurm job
======================================

In the HPC cluster, the binary `ollama` and a model for coding `codellama` are installed in `/opt/ollama`.

User can start a ollama server using the script `/opt/ollama/ollama_serve.sh` using the command below:

.. code-block:: bash

    $ sbatch --time=1:00:00 /opt/ollama/ollama_serve.sh

The job requests 1 CPU, 1GPU and 64GB memory resource to run on, and for 1 hour.  Once the job is started, check the output file ``ollama-gpu-{jobid}.out`` and find the server endpoint.

The example below shows you the OLLAMA job ``46131868`` is started and listen on endpoint ``dccn-c083.dccn.nl:11434``.

.. code-block:: bash

    $ cat ollama-gpu-46131868.out
    ...
    starting OLLAMA to listen on dccn-c083.dccn.nl:11434 ...
    ...

.. note::
    As the started server is capable for serving multiple clients at the same time, it is possible to use the same server endpoint in multiple clients as long as the client can access the DCCN network (e.g. via `eduVPN Trigon full access profile <https://intranet.donders.ru.nl/index.php?id=eduvpn>`__).  Please keep in mind that the data transferred between the server and the clients are not encrypted.

Connecting clients to the OLLAMA server
=======================================

On the access node, open a new terminal and run

.. code-block:: bash

    $ OLLAMA_HOST=dccn-c083.dccn.nl:11434 /opt/ollama/0.3.9/bin/ollama run codellama

It can take a while when the server is loading the model.  Once succeeded, you should get a "chat" prompt back as below:

.. code-block::

    >>> Send a message (/? for help)

Now you can chat with the model just like using the ChatGPT, for example,

.. code-block::

    >>> hello

    Hey there! How's it going?

    >>> who are you?

    I am LLaMA, an AI assistant developed by Meta AI that can understand and respond to human input in a
    conversational manner. I am trained on a massive dataset of text from the internet and can answer questions
    or provide information on a wide range of topics.

Connecting VSCode to the OLLAMA server
======================================

On VSCode IDE, one can install the plugin `Continue <https://www.continue.dev/>`__ to connect to the OLLAMA server.

After the installation, the Continue panel is accessible via the :kbd:`Ctrl/Cmd` + :kbd:`l` key-binding.  Before starting using it, one needs to configure the model provider endpoint as follows:

#. open the Continue configuration file, see `this instruction <https://docs.continue.dev/customize/overview#editing-configjson>`__.

#. given the ollama server endpoint ``dccn-c083.dccn.nl:11434`` and the ``codellama`` model, we modify the configuration JSON file accordingly as below:

    .. code-block:: JSON

        {
            "models": [
                {
                "title": "Code Llama",
                "provider": "ollama",
                "apiBase": "http://dccn-c083.dccn.nl:11434",
                "model": "codellama"
                }
            ],
            ...
        }

After that, in the Continue chat pannel toggled with the :kbd:`Ctrl/Cmd` + :kbd:`l` key-binding, you can start chatting with the model.


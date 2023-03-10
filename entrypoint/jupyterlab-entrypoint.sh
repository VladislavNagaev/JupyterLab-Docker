#!/bin/bash

COMMAND="${1:-}";

jupyterlab-termination() {
    source /entrypoint/jupyterlab-termination.sh $COMMAND;
};

source /entrypoint/wait_for_it.sh;

source /entrypoint/font-colors.sh;
source /entrypoint/jupyterlab-initialization.sh $COMMAND &

trap jupyterlab-termination SIGTERM HUP INT QUIT TERM;

# Wait for any process to exit
wait -n;

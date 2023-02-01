#!/bin/bash

COMMAND="${1:-}"

if [ "${COMMAND}" == "jupyterlab" ]; then

    echo "Starting Jupyter Lab ..."

    jupyter lab --ip=0.0.0.0 --port=${SPARK_JUPYTERLAB_PORT:-8888} --no-browser --allow-root --NotebookApp.token=""

fi

exit $?

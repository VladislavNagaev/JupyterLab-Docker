#!/bin/bash

COMMAND="${1:-}"

if [ "${COMMAND}" == "jupyterlab" ]; then

    echo "Ending Jupyter Lab ..."

    jupyter lab stop ${SPARK_JUPYTERLAB_PORT:-8888}

fi

exit $?

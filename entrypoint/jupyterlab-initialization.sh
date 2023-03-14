#!/bin/bash

COMMAND="${1:-}";

if [ "${COMMAND}" == "jupyterlab" ]; then

    echo -e "${blue_b}Starting Jupyter Lab ...${reset_font}";

    jupyter lab --ip=0.0.0.0 --port=${JUPYTERLAB_PORT:-8888} --no-browser --allow-root --NotebookApp.token="";

fi;

exit $?;

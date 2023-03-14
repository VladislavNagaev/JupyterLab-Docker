#!/bin/bash

COMMAND="${1:-}";

if [ "${COMMAND}" == "jupyterlab" ]; then

    echo -e "${blue_b}Ending Jupyter Lab ...${reset_font}";

    jupyter lab stop ${JUPYTERLAB_PORT:-8888};

fi;

exit $?;

#!/bin/bash

DATA_VOLUME=/home/emanuel/Documents/IUA/Materias4to/BaseDatos2/conDocker/schemaWorkbench/conector

xhost +SI:localuser:root > /dev/null 2>&1
docker run -e DISPLAY=$DISPLAY \
           -v $DATA_VOLUME:/schema-workbench/drivers \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           --name pentaho-schema-workbench \
           --rm \
           lucianofromtrelew/pentaho-schema-workbench

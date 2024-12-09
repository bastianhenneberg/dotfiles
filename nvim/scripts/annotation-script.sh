#!/bin/bash

set -e

read -p "Name: " NAME
task add $NAME
ID=$(task +LATEST ids)
# read -p "Annotation: " ANNOTATION
task $ID annotate $@
# task $ID annotate "nvim +42 /home/bastian/Development/zkn_backend/README.md"

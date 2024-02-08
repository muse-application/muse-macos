#!/bin/bash

if [[ "$1" == *"feat"* ]]; then
    echo "feature"
elif [[ "$1" == *"bug"* ]]; then
    echo "bug"
elif [[ "$1" == *"doc"*]]; then
    echo "documentation"
fi

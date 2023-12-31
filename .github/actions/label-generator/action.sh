#!/bin/bash

if [[ "$1" == *"feature"* ]]; then
    echo "feature"
elif [[ "$1" == *"bug"* ]]; then
    echo "bug"
fi

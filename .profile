#!/bin/bash

# This file is a trick. It actually reads .env and parse it with different functions in bash and fish
# See https://unix.stackexchange.com/a/176331

# This is the function for bash
function setenv() { export "$1=$2"; }

# And actually reading the variables
. $HOME/.env

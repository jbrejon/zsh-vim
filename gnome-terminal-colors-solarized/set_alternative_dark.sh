#!/usr/bin/env bash

dir=`dirname $0`

PROFILE=${1:-Default}

$dir/install.sh -s dark_alternative -p "$PROFILE"

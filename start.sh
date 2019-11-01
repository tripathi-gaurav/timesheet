#!/bin/bash

export MIX_ENV=prod
export PORT=5001

echo "Starting app..."

# Start to run in background from shell.
source ./prod-env.sh
# Foreground for testing and for systemd
_build/prod/rel/timesheet/bin/timesheet start




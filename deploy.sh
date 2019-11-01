#!/bin/bash

export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

source ./prod-env.sh

# Build Elixir Code
mix deps.get
mix compile

# Build Assets
mkdir -p priv/static
(cd assets && npm install)
(cd assets && webpack --mode production)
mix phx.digest

#printing vars
echo $MIX_ENV
echo $PORT


# Migrate DB
mix ecto.migrate

# Generate the release
mix release

echo "Starting the app..."
#start the application
_build/prod/rel/timesheet/bin/timesheet start

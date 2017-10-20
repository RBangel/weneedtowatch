#!/bin/bash

set -e

host="$1"
shift
cmd="$@"

until psql -h "$host" -U "postgres" -c '\l'; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1
done

if [ $? -eq 0 ]; then
    >&2 echo "cmd arg: ${cmd}"

    >&2 echo "Postgres is up - setting up the database"
    mix ecto.setup

    >&2 echo "Entering app"
    exec $cmd
fi

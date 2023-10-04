#!/bin/bash

# turn on bash's job control
set -m

echo "Starting nginx.."
nginx &
echo "Starting our application.."
cd source && python -m flask run --host=0.0.0.0
sleep infinity

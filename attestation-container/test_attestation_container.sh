#!/bin/bash
set -euo pipefail

# Change current directory to this file's location
cd "$(dirname "$(readlink -f "$0")")"

echo "Building docker container..."
docker build -t attestation-container .

echo "Starting docker container..."
docker run -d --rm -p 50051:50051 attestation-container

# Wait for the server to start (Need to tidy up)
sleep 10

echo "Calling API..."
cd tools/client
go run .


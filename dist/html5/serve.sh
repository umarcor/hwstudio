#!/usr/bin/env sh

cd $(dirname "$0")

docker run --rm -itv /$(pwd)://src -w //src -p 8000:8000 php -S 0.0.0.0:8000

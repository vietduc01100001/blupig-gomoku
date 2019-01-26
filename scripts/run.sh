#!/bin/sh
docker stop gomoku-server
docker run -d -p "$1":3500 --name gomoku-server gomoku-server

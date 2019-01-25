#!/bin/sh

docker stop gomoku
docker build -t yunzhu/gomoku . && \
docker run -d --rm -p 8000:8000 -e SERVER_URI="http://localhost:8000" --name gomoku yunzhu/gomoku

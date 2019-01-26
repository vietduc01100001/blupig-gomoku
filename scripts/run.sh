#!/bin/sh
docker stop gomoku
docker run -d -p 8000:8000 -p 8001:8001 -e SERVER_URI="http://localhost:8001" --name gomoku gomoku

#!/bin/sh
set -euo pipefail

# Replace server URI and path
sed -i "s|const api_base_url.*|const api_base_url = '$SERVER_URI';|" /app/client/index.html

# Start nginx daemon
nginx

# Start Node.js server
cd /app/server
exec npm start

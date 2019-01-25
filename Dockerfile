# Build container
FROM alpine

# Install build-time packages
RUN apk --no-cache add nginx alpine-sdk cmake bash

# Set workdir
WORKDIR /app/build

# Copy code
COPY . /app

# Build program then remove building toolchain
RUN cmake .. && \
    make install && \
    apk del --no-cache alpine-sdk cmake

# Runtime container
FROM node:8-alpine

# Install nginx
RUN apk --no-cache add nginx

# Copy nginx configuration
COPY docker-nginx.conf /etc/nginx/nginx.conf

# Copy built binary from build container
COPY --from=0 /app/build/gomoku /bin/gomoku

# Copy code
COPY . /app

# Install node.js dependencies
RUN cd /app/gui/server && npm install

# nginx listens on 8000
EXPOSE 8000

# Set command
CMD ["/app/docker-start.sh"]

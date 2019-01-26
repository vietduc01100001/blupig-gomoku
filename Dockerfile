# Build stage
FROM alpine AS build

WORKDIR /app/build

RUN apk add --no-cache alpine-sdk cmake

COPY include /app/include

COPY src /app/src

COPY CMakeLists.txt /app

RUN cmake .. && make install

# Final stage
FROM node:lts-alpine AS final

WORKDIR /app

RUN apk add --no-cache nginx

COPY docker-nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/build/gomoku /bin/gomoku

COPY gui/server/package.json ./server/

RUN cd server && npm install --production

COPY gui/client ./client/

COPY gui/server ./server/

COPY scripts/docker-start.sh .

EXPOSE 8000 8001

CMD ["./docker-start.sh"]

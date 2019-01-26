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

COPY gui/server/package.json .

RUN npm install --production

COPY gui/server scripts/docker-start.sh ./

EXPOSE 3500

CMD ["./docker-start.sh"]

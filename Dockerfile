# Build stage
FROM alpine AS build

WORKDIR /app/build

RUN apk add --no-cache alpine-sdk cmake

COPY . /app

RUN cmake .. && make install

# Final stage
FROM node:lts-alpine AS final

WORKDIR /app

RUN apk add --no-cache nginx

COPY docker-nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/build/gomoku /bin/gomoku

COPY gui/server/package.json gui/server/

RUN cd gui/server && npm install --production

COPY . .

EXPOSE 8000 8001

CMD ["/app/scripts/docker-start.sh"]

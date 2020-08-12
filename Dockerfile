## build stage
FROM golang:1.14-alpine AS builder
WORKDIR /go/src/github.com/imrancluster/umara-store
COPY . .

RUN set -e
RUN apk add git
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -a -o dist/umarastore


## certs stage, need openssl as well?
FROM alpine:latest as certs
RUN apk --update add ca-certificates curl
WORKDIR /app
COPY --from=builder /go/src/github.com/imrancluster/umara-store/dist/umarastore .
COPY config.yaml .
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
LABEL Name=umara-store Version=0.0.1
EXPOSE 5000
CMD ["./entrypoint.sh"]

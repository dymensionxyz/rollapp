FROM golang:1.19-alpine3.16 as go-builder

WORKDIR /app

COPY go.mod go.sum* ./

RUN go mod download

COPY . .

ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3

RUN apk add --no-cache $PACKAGES

RUN make build

FROM alpine:3.16.1

RUN apk add curl jq bash vim 

COPY --from=go-builder /app/build/rollappd /usr/local/bin/

WORKDIR /app

EXPOSE 26657 1317
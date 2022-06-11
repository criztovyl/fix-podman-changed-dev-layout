FROM docker.io/golang

RUN go install github.com/spacewander/boltcli@latest

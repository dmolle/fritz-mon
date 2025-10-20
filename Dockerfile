FROM golang:1.25 AS builder

WORKDIR /fritz
COPY go.mod go.sum ./
RUN go mod download
COPY / ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /fritz-mon

FROM gcr.io/distroless/static-debian13:nonroot
WORKDIR /
COPY --from=builder /fritz-mon /fritz-mon
ENTRYPOINT  ["/fritz-mon"]
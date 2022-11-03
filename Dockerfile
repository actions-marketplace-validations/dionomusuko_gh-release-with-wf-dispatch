FROM golang:1.19-buster AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /bin/app

FROM gcr.io/distroless/base
COPY --from=builder /bin/app /bin/app
ENTRYPOINT ["/bin/app"]

FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -ldflags "-linkmode external -extldflags -static" -o myapp .

FROM scratch

COPY --from=builder /app/myapp /

CMD ["/myapp"]

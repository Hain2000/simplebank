FROM golang:1.23.2 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run stage
FROM ubuntu:latest
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 8081
CMD [ "./main" ]
FROM golang:1.23.2 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.1/migrate.linux-amd64.tar.gz | tar xvz
RUN ls -l /app

# Run stage
FROM ubuntu:latest
WORKDIR /app
RUN apt-get update && apt-get install -y netcat-openbsd wget && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./db/migration
RUN chmod +x /app/start.sh /app/wait-for.sh /app/migrate

EXPOSE 8081
CMD [ "./main" ]
ENTRYPOINT ["/app/start.sh"]
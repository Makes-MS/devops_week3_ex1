FROM quay.io/projectquay/golang:1.20

WORKDIR /app

COPY . .

RUN go mod download

CMD ["go", "test", "./..."]
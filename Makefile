IMAGE_NAME=devops_week3_ex1
IMAGE_TAG=${IMAGE_NAME}:latest

PLATFORMS=linux/amd64,linux/arm64,darwin/amd64,darwin/arm64,windows/amd64

GO=go

.PHONY: all clean linux arm mac windows docker-build

all: linux arm mac windows

linux:
	GOOS=linux GOARCH=amd64 $(GO) build -o bin/linux/myapp ./...
	GOOS=linux GOARCH=arm64 $(GO) build -o bin/linux/arm/myapp ./...

arm:
	GOOS=linux GOARCH=arm64 $(GO) build -o /bin/arm/myapp ./...

mac:
	GOOS=darwin GOARCH=amd64 $(GO) build -o /bin/mac/myapp ./...
	GOOS=darwin GOARCH=arm64 $(GO) build -o /bin/mac/arm/myapp ./...

windows:
	GOOS=windows GOARCH=amd64 $(GO) build -o /bin/windows/myapp.exe ./...

docker-build:
	docker buildx build \
		--platform $(PLATFORMS) \
		-t quay.io/Makes-MS/$(IMAGE_TAG) \
		-f Dockerfile .

clean:
	rm -rf bin
	docker rmi quay.io/Makes-MS/$(IMAGE_TAG) || true
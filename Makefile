.DEFAULT_GOAL := run

IMAGE_NAME := raspi-debuild

.PHONY: build
build: .build

.build: Dockerfile
	docker build -t $(IMAGE_NAME) .
	touch "$@"

.PHONY: run
run: build
	docker run -it --rm -v `pwd`:/host $(IMAGE_NAME)

.PHONY: clean
clean:
	$(RM) .build
	docker rmi $(IMAGE_NAME) || true

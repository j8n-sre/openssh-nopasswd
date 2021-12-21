NAME = harbor.ajway.kr/platform/centos7
VERSION = cerp-mig-6

all: build push

build:
	docker build -t $(NAME):$(VERSION) --rm .


push:
	docker push $(NAME):$(VERSION)


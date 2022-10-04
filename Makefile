.DEFAULT_GOAL := help

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m   %s\n", $$1, $$2}'
build: infra-build  ## build docker images
run: infra-up ## run infrastructure
network: network-create ## create network
ifndef env
getenv=$(error var:"env=" is not set)
else
getenv=$(env)
endif

infra-build:
	docker build -t aboudev/syslog .
network-create:
	docker network create --subnet 172.17.2.0/24 sp-sd-network

infra-up: network-create
	docker-compose -f SP/docker-compose.yaml up -d \
	&& docker-compose -f SD/docker-compose.yaml up -d \
	&& docker-compose -f SA/docker-compose.yaml up -d \
	&& docker-compose -f SL/docker-compose.yaml up -d \




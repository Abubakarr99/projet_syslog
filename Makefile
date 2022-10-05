.DEFAULT_GOAL := help

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m   %s\n", $$1, $$2}'
build: infra-build  ## build docker images
run: infra-up ## run infrastructure
network: network-create ## create network
push: docker-push ## push docker image
shutdown: docker-down ## shutdown infra
ifndef env
getenv=$(error var:"env=" is not set)
else
getenv=$(env)
endif

infra-build:
	docker-compose  -f SP/docker-compose.yaml build \
	 && docker-compose  -f SD/docker-compose.yaml build
docker-push: infra-build
	docker push aboudev/syslog-sp \
	&& docker push aboudev/syslog-sd

network-create:
	docker network create --subnet 172.17.2.0/24 sp-sd-network

infra-up: infra-build
	docker-compose -f SP/docker-compose.yaml up -d \
	&& docker-compose -f SD/docker-compose.yaml up -d 

docker-down: 
	docker-compose -f SP/docker-compose.yaml down \
        && docker-compose -f SD/docker-compose.yaml down



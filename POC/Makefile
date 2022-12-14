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
	 && docker-compose  -f SD/docker-compose.yaml build \
	 && docker-compose  -f SA/docker-compose.yaml build \
	 && docker-compose  -f SL/docker-compose.yaml build \
	 && docker-compose  -f SM/docker-compose.yaml build \
	 && docker-compose  -f SB/docker-compose.yaml build 

docker-push: infra-build
	docker push aboudev/syslog-sp \
	&& docker push aboudev/syslog-sd \
	&& docker push aboudev/syslog-sa \
	&& docker push aboudev/syslog-sl \
	&& docker push aboudev/syslog-sm \
	&& docker push aboudev/syslog-sb 


network-create:
	docker network create --subnet 10.1.1.0/24 sp-sd-network \
	&& docker network create --subnet 10.1.2.0/24 site-local \
	&& docker network create --subnet 10.1.3.0/24 backup 




infra-up: infra-build
	docker-compose -f SP/docker-compose.yaml up -d \
	&& docker-compose -f SD/docker-compose.yaml up -d \
	&& docker-compose -f SA/docker-compose.yaml up -d \
	&& docker-compose -f SL/docker-compose.yaml up -d \
	&& docker-compose -f SM/docker-compose.yaml up -d \
	&& docker-compose -f SB/docker-compose.yaml up -d 

docker-down: 
	docker-compose -f SP/docker-compose.yaml down \
        && docker-compose -f SD/docker-compose.yaml down \
        && docker-compose -f SA/docker-compose.yaml down \
        && docker-compose -f SL/docker-compose.yaml down \
        && docker-compose -f SM/docker-compose.yaml down \
        && docker-compose -f SB/docker-compose.yaml down



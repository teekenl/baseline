# Makefile

# absolute path to the construction site
radish34=./radish34

# over time, as the radish34 use-case is abstracted/generalized into
# the baseline protocol, the pushd/popd hacks will fade away...

.PHONY: build clean contracts deploy-contracts npm-install start stop test zk-circuits

default: build

build: npm-install contracts
	pushd ${radish34} && \
	docker-compose build && \
	npm run setup && \
	popd

clean: stop
	docker container prune -f
	docker network prune -f
	$(radish34)/../bin/clean_npm.sh

contracts:
	pushd ${radish34} && \
	npm run build:contracts && \
	popd

deploy-contracts:
	pushd ${radish34} && \
	npm run deploy && \
	popd

npm-install:
	pushd ${radish34} && \
	npm ci && npm run postinstall && \
	popd

start:
	pushd ${radish34} && \
	npm run deploy && \
	docker-compose up -d && \
	popd

stop:
	pushd ${radish34} && \
	docker-compose down && \
	popd

test:
	pushd ${radish34} && \
	npm run test && \
	popd

zk-circuits:
	pushd ${radish34} && \
	npm run setup && \
	popd

DEBUG ?= false
HOME ?= $(HOME)
USER ?= $(USER)
UID ?= $(shell id -u)
GID ?= $(shell id -g)

-include .env
export $(shell sed 's/=.*//' .env)

.PHONY: env_var
env_var: # Print environnement variables
	@cat .env
	@echo HOME=$(HOME)
	@echo USER=$(USER)
	@echo UID=$(UID)
	@echo GID=$(GID)

.PHONY: env
env: # Init default value
	cp .env.default .env

.PHONY: build-all
build-all: build-base

.PHONY: all-base
all-base: build-base run-base

.PHONY: build-base
build-base: # Build docker image locally
	docker build ./base -t stl-base:latest \
		--build-arg STL_BASE_IMAGE \
		--build-arg STL_BASE_TAG \
		--build-arg HOST_USER=${USER} \
		--build-arg HOST_UID=${UID} \
		--build-arg HOST_GID=${GID}

.PHONY: run-base
run-base: # -u ${UID}:${GID}
	docker run -it --rm --name stl-base --hostname stl-base -v ${HOME}:${HOME} stl-base:latest


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
	@echo XAUTHORITY=$(XAUTHORITY)

.PHONY: env
env: # Init default value
	cp .env.default .env
	systemctl --user show-environment | grep XAUTHORITY>>.env


### all

.PHONY: build
build: base-build x11-build xeyes-build


### base

.PHONY: base-build
base-build:
	docker build ./base -t stl-base:latest \
		--build-arg STL_BASE_IMAGE \
		--build-arg STL_BASE_TAG

.PHONY: base-run
base-run:
	docker run -it --rm stl-base:latest


### x11

.PHONY: x11-build
x11-build:
	docker build ./x11 -t stl-x11:latest \
		--build-arg HOST_USER=${USER} \
		--build-arg HOST_UID=${UID} \
		--build-arg HOST_GID=${GID}

.PHONY: x11-run
x11-run:
	docker run -it --rm \
		-w /root \
		-e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-v ${XAUTHORITY}:/root/.Xauthority:ro \
		stl-x11:latest


### xeyes

.PHONY: xeyes-build
xeyes-build:
	docker build ./xeyes -t stl-xeyes:latest

.PHONY: xeyes-run
xeyes-run:
	docker run -it --rm \
		-u ${USER} -w /home/${USER} \
		-e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		stl-xeyes:latest


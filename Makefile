DEBUG ?= false
HOME ?= $(HOME)
USER ?= $(USER)
UID ?= $(shell id -u)
GID ?= $(shell id -g)
ROOT_ARGS=-w /root --entrypoint bash -v ${XAUTHORITY}:/root/.Xauthority:ro
USER_ARGS=-u ${USER} -w /home/${USER}
X11_ARGS=-e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro

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
	@echo ROOT_ARGS=$(ROOT_ARGS)
	@echo USER_ARGS=$(USER_ARGS)
	@echo X11_ARGS=$(X11_ARGS)

.PHONY: env
env: # Init default value
	cp .env.default .env
	systemctl --user show-environment | grep XAUTHORITY>>.env


### all

.PHONY: build
build: base-build x11-build xeyes-build firefox-build


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

.PHONY: x11
x11:
	docker run -it --rm ${ROOT_ARGS} ${X11_ARGS} stl-x11:latest


### xeyes

.PHONY: xeyes-build
xeyes-build:
	docker build ./xeyes -t stl-xeyes:latest

.PHONY: xeyes
xeyes:
	docker run -it --rm ${USER_ARGS} ${X11_ARGS} stl-xeyes:latest


### firefox

.PHONY: firefox-build
firefox-build:
	docker build ./firefox -t stl-firefox:latest

.PHONY: firefox
firefox:
	docker run -it --rm ${USER_ARGS} ${X11_ARGS} stl-firefox:latest "--new-instance"

.PHONY: firefox-admin
firefox-admin:
	docker run -it --rm	${ROOT_ARGS} ${X11_ARGS} stl-firefox:latest


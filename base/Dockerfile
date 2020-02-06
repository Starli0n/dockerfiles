ARG  STL_BASE_IMAGE
ARG  STL_BASE_TAG
FROM ${STL_BASE_IMAGE}:${STL_BASE_TAG}

RUN apt-get update && apt-get install -y \
	zsh \
	sudo \
	&& rm -rf /var/lib/apt/lists/*

# Add a host user on the container
ARG HOST_USER
ARG HOST_UID
ARG HOST_GID
RUN addgroup --gid ${HOST_GID} ${HOST_USER} && \
	adduser --uid ${HOST_UID} --gid ${HOST_GID} \
		--gecos ${HOST_USER} --home /home/${HOST_USER} --shell /usr/bin/zsh --disabled-password ${HOST_USER} && \
	mkdir -p /etc/sudoers.d/	&& \
	echo "${HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${HOST_USER} && \
	chmod 0440 /etc/sudoers.d/${HOST_USER} && \
	chown ${HOST_UID}:${HOST_GID} -R /home/${HOST_USER}

USER "${HOST_USER}"
WORKDIR "/home/${HOST_USER}"

ENTRYPOINT /usr/bin/zsh


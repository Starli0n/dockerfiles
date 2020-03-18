FROM stl-base:latest

# Add a host user on the container
ARG HOST_USER
ARG HOST_UID
ARG HOST_GID

RUN groupadd --gid ${HOST_GID} ${HOST_USER} && \
	useradd --uid ${HOST_UID} --gid ${HOST_GID} --home /home/${HOST_USER} --create-home --shell /usr/bin/bash ${HOST_USER} && \
	mkdir -p /etc/sudoers.d/	&& \
	echo "${HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${HOST_USER} && \
	chmod 0440 /etc/sudoers.d/${HOST_USER}

# Make variable available for other images
ENV HOST_USER ${HOST_USER}


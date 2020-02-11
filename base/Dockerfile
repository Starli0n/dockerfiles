ARG  STL_BASE_IMAGE
ARG  STL_BASE_TAG
FROM ${STL_BASE_IMAGE}:${STL_BASE_TAG}

RUN apt-get update && apt-get upgrade -y \
	&& rm -rf /var/lib/apt/lists/*


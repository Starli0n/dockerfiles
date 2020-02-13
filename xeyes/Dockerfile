FROM stl-user:latest

RUN apt-get update && apt-get install -y \
	x11-apps \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["xeyes"]


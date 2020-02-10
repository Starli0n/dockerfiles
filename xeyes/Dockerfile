FROM stl-x11:latest

RUN apt-get update && apt-get install -y \
	x11-apps \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["xeyes"]


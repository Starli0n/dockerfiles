FROM stl-user:latest

RUN apt-get update && apt-get install -y \
	firefox \
	libcanberra-gtk3-module \
	dbus-x11 \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["firefox"]


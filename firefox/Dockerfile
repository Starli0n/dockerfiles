FROM stl-user:latest

# https://github.com/jessfraz/dockerfiles/blob/master/firefox/Dockerfile
# https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc#L248

# https://github.com/jlesage/docker-firefox/blob/master/Dockerfile


RUN apt-get update && apt-get install -y \
	firefox \
	libcanberra-gtk3-module \
	dbus-x11 \
	gnome-icon-theme \
	apulse \
	ca-certificates \
	ffmpeg \
	hicolor-icon-theme \
	libasound2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	fonts-noto \
	fonts-noto-cjk \
	fonts-noto-color-emoji \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["apulse", "firefox"]


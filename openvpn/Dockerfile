FROM stl-x11:latest

RUN apt-get update && apt-get install -y \
	openvpn \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /ovpn

# TUN Configuration (OpenVPN Configuration for Smart Phone)
ENTRYPOINT ["openvpn", "--config", "client3.ovpn"]


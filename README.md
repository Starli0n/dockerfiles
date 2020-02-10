# dockerfiles
Some dockerfiles to run on the desktop


## X11

* Locate `Xauthority`, on Ubuntu 19.10 `~/.Xauthority` is not present

```
$ ps aux | grep -i xorg
... /run/user/1000/gdm/Xauthority

$ systemctl --user show-environment | grep XAUTHORITY
XAUTHORITY=/run/user/1000/gdm/Xauthority

$ xauth -f /run/user/1000/gdm/Xauthority list
```

* Export `$DISPLAY` variable to the container

* Share `/tmp/.X11-unix` directory

* On the host, tweak the access control `+` or `-`
```
$ xhost +
access control disabled, clients can connect from any host

$ xhost -
access control enabled, only authorized clients can connect

```

* Methods to make a X11 app works

1. Share `Xauthority` file with the container as root `-v ${XAUTHORITY}:/root/.Xauthority:ro` (user id (1000) of the host is suppossed to be different as root (0) but the later as the right to read the file `/root/.Xauthority`

2. Create a user in the container with the same id of the user of the host (no need to share the `Xauthority` file)
```
# From container (aka Dockerfile)
useradd --uid ${HOST_UID} --home /home/${HOST_USER} --create-home --shell /usr/bin/bash ${HOST_USER}
```
and run the container with the flag `-u ${HOST_USER}`

3. The container user as an id different than the id of the host, add the magic token from the host to the container
```
# From host
$ xauth -f $(XAUTHORITY) list
<MIT-MAGIC-COOKIE-1>

# From container
$ xauth add $DISPLAY . <MIT-MAGIC-COOKIE-1>
```

4. Disable access control with `$ xhost +` (unsecured)


## Yes, I Know IT !

[How to Run a Graphical Application from a Container? Yes, I Know IT! Ep 20](https://www.youtube.com/watch?v=Jp58Osb1uFo)


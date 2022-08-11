## xorg docker images

Contains xorg images with x11vnc, dwm tiling manager with no UI


### Debug tips

#### local X11 on vfb and vnc


    docker build -t xserver:dev -f xserver-full.Dockerfile .
    docker run -it --net=host --rm --privileged --name xserver-test xserver:dev sh

    export DISPLAY=:1
    Xvfb $DISPLAY -screen 0 1024x768x24 &
    x11vnc -shared -forever &
    dwm

#### test apps

    # inside container or host
    apk add xterm xeyes
    DISPLAY=:1 xterm &
    DISPLAY=:1 xeyes &

#### vnc connect

    vncviewer localhost:0

#### Minimal GPU device passthrough

    docker run --privileged --net=host -it --rm
        --device=/dev/nvidia0:/dev/nvidia0 \
        --device=/dev/nvidia-caps:/dev/nvidia-caps \
        --device=/dev/nvidiactl:/dev/nvidiactl \
        --device=/dev/nvidia-modeset:/dev/nvidia-modeset \
        --device=/dev/nvidia-uvm:/dev/nvidia-uvm \
        --device=/dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools \
        -v /usr/lib/x86_64-linux/:/usr/lib/x86_64-linux/ nvidia-510 sh

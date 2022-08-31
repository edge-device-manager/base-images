#!/bin/sh

if [ ! -z $RESOLUTION ]; then
    echo "**** Starting VFB $RESOLUTION at $DISPLAY"
    Xvfb $DISPLAY -screen 0 $RESOLUTION &
else
    SOCKET="/tmp/.X11-unix/$(echo $DISPLAY | sed -e "s/:/X/g")"
    echo "**** Checking socket $SOCKET"

    if [ -S "$SOCKET" ]; then
        echo "Socket already exists"
        exit 1
    fi

    echo "**** Starting X server"
    /usr/bin/X -nocursor &
fi

echo "**** Waiting for X server to start"
while ! xset q > /dev/null 2>&1 ; do
    sleep 1
done

if [ ! -z $VNC_PORT ]; then
    echo "**** Starting VNC server at $VNC_PORT"
    x11vnc -shared -forever -ncache 10 -httpport $VNC_PORT &
fi

echo "**** Starting window manager"
dwm

#!/bin/sh

if [ ! -z $RESOLUTION ]; then
    echo "**** Starting VFB $RESOLUTION at $DISPLAY"
    Xvfb $DISPLAY -screen 0 $RESOLUTION &
else
    echo "**** Starting X server"
    /usr/bin/X -nocursor &
fi

echo "**** Waiting for X server to start"
while ! timeout 5 xset q > /dev/null 2>&1 ; do
    sleep 1
done

if [ ! -z $VNC_PORT ]; then
    echo "**** Starting VNC server at $VNC_PORT"
    x11vnc -shared -forever -ncache 10 -httpport $VNC_PORT &
fi

echo "**** Starting window manager"
dwm

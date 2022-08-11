FROM alpine:3.15.0

RUN apk update && apk add xorg-server mesa-dri-gallium mesa-egl mesa-demos mesa-va-gallium mesa-vdpau-gallium xf86-video-fbdev xf86-video-vesa
RUN if [ "x86_64" = "$(uname -m)" ] ; then apk add xf86-video-qxl xf86-video-nouveau xf86-video-vmware ; fi


RUN apk add x11vnc

# TODO: replace with custom dwm
RUN apk update && apk add dwm

# display tweak
COPY scripts/xorg/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf

CMD /usr/bin/X -nocursor


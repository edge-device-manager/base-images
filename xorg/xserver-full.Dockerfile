FROM alpine:3.15.0 as dwm-builder

RUN apk add build-base git libx11-dev libxft-dev libxinerama-dev freetype-dev
WORKDIR /ws
RUN git clone --depth=1 --branch=6.3 https://git.suckless.org/dwm /ws/dwm
# standard dwm build has a UI enabled
# generate config with hide bar
WORKDIR /ws/dwm
RUN cp config.def.h config.h
# showbar = 0 - hide bottom bar
RUN sed -E -i.bak 's/(static const int showbar *= *)\d;/\10;/' config.h
# topbar = 0 - hide interactive top taskbar
RUN sed -E -i.bak 's/(static const int topbar *= *)\d;/\10;/' config.h
# resizehints = 0 - to avoid misaligned windows
RUN sed -E -i.bak 's/(static const int resizehints *= *)\d;/\10;/' config.h
RUN make


FROM alpine:3.15.0

RUN apk update && apk add xorg-server mesa-dri-gallium mesa-egl mesa-demos mesa-va-gallium mesa-vdpau-gallium xf86-video-fbdev xf86-video-vesa
RUN if [ "x86_64" = "$(uname -m)" ] ; then apk add xf86-video-qxl xf86-video-nouveau xf86-video-vmware ; fi


RUN apk add x11vnc xvfb

#RUN apk add dwm
# use customized non-interactive dwm
COPY --from=dwm-builder /ws/dwm/dwm /usr/bin/dwm

# display tweak
COPY scripts/xorg/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf

CMD /usr/bin/X -nocursor


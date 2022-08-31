IMG := harbor.xored.com/k8/xserver:dev

build:
	docker build -t $(IMG) .
	docker push $(IMG)

# Run virtual framebuffer
# How to test:
# on host:
# - make run-vfb
# - vncviewer localhost:0
# - DISPLAY=:1 xeyes
# you should see running eyes in vncviewer
run-vfb:
	docker run --privileged --ipc=host --net=host --rm \
		-e DISPLAY=:1 \
		-e RESOLUTION=1024x768x24 \
		-e VNC_PORT=5900 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--name xserver-test $(IMG)

# Connect to the host's X server which is most likely on DISPLAY=:0
# How to test:
# on host:
# - DISPLAY=:0 xhost +     !!! this disables x-server authorization
# - make run-host
# - make shell
# in container's shell:
# - apk add xeyes
# - xeyes
# you should see running eyes on host's screen
run-host:
	docker run --privileged --ipc=host --net=host --rm \
		-e DISPLAY=:0 \
		-e VNC_PORT=5900 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--name xserver-test $(IMG)

shell:
	docker exec -it xserver-test sh

stop:
	docker stop xserver-test

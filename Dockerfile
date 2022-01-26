ARG DOCKER_IMAGE=alpine:latest
FROM $DOCKER_IMAGE

RUN apk add --no-cache bash gcc g++ ninja libpng-dev bison make cmake git \
	&& git clone --recurse-submodules https://github.com/gbdev/rgbds.git
WORKDIR /rgbds

RUN cmake -GNinja -S . -B build -DCMAKE_BUILD_TYPE=Release \
	&& ninja -C build \
	&& ninja -C build install \
	&& ls -lah


WORKDIR /usr/src/myapp

CMD make clean && make
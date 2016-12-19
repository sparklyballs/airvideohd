FROM lsiobase/xenial
MAINTAINER madcatsu

# package versions
ARG AVSERVERHD_VERSION="2.2.3"

# global environment settings
ENV LANG C.UTF-8

# build environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	--no-install-recommends \
	vlc-nox && \
 apt-get install -y \
	avahi-daemon \
	bzip2 \
	dbus && \

# install airvideo
 mkdir -p \
	/opt/airvideohd && \
 curl -o \
 /tmp/airvideo.tar.bz2 -L \
	"https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-${AVSERVERHD_VERSION}.tar.bz2" && \
 tar xjf \
 /tmp/airvideo.tar.bz2 -C \
	/opt/airvideohd --strip-components=1 && \

# cleanup
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/*

# copy local files
COPY /root /

# ports and volumes
EXPOSE 45633 5353/udp
VOLUME /config /media /transcode

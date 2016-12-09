FROM lsiobase/xenial
MAINTAINER madcatsu

# AirVideo Server HD version
ARG AVSERVERHD_VERSION="2.2.3"

# Set necessary build attributes
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEPENDENCIES="\
  wget \
  bzip2 \
  avahi-daemon \
  dbus"
ENV LANG C.UTF-8

# Install required packages
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends vlc-nox && \
  apt-get install -y $DEPENDENCIES && \

# Create fetch binary and unpack
  wget -qO \
    /tmp/avhd-pkg.tar.bz2 -L \
    "https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-${AVSERVERHD_VERSION}.tar.bz2" && \
  tar xjf /tmp/avhd-pkg.tar.bz2 -C /opt && \

# Clean up
  apt-get purge -y wget bzip2 && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* /tmp/*

# Add local defaults
COPY /root /

# Setup ports and volumes for mapping
EXPOSE 45633 5353/udp
VOLUME /config /transcode /multimedia

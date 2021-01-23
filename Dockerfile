FROM ivonet/x11webui:latest
LABEL maintainer="Ivo Woltring - @ivonet"


RUN export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get remove alsa-base dbus dbus-x11 -y \
 && apt-get install -y --no-install-recommends \
     binutils \
     ca-certificates \
     gcc \
     git \
     golang \
     libgl1-mesa-dev \
     libgl1-mesa-dri \
     libxcursor-dev \
     libxi-dev \
     libxinerama-dev \
     libxrandr-dev \
     mercurial \
     portaudio19-dev \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean \
 && ldconfig


ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN go get github.com/fogleman/nes

WORKDIR /root

COPY root/ /

ARG APP=nes
ARG USR=user
ARG PWD=secret

ENV APPNAME=$APP      \
    USERNAME=$USR     \
    GPASSWORD=$PWD

VOLUME ["/nobody"]



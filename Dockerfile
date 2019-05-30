FROM ivonet/x11webui:latest
LABEL maintainer="Ivo Woltring - @ivonet"

ARG APP=nes
ARG USR=user
ARG PWD=secret

ENV APPNAME=$APP      \
    USERNAME=$USR     \
    GPASSWORD=$PWD

COPY root/ /

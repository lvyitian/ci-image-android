FROM debian:buster-slim

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk

WORKDIR /opt/briar-ci

ADD install.sh ./
ADD test.sh ./

RUN ./install.sh

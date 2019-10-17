FROM debian:stretch-slim
# buster brings opendjk-11 which sdkmanager is currently not compatible with
# see https://stackoverflow.com/q/46402772

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk

WORKDIR /opt/briar-ci

ADD install.sh ./
ADD test.sh ./

RUN ./install.sh

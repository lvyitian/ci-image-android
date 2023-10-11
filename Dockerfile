FROM debian:bookworm-slim

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

WORKDIR /opt/briar-ci

ADD install.sh ./
ADD test.sh ./

RUN ./install.sh

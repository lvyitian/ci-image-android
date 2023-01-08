#!/usr/bin/env bash
set -e
set -x

###############
# Debian Part #
###############

# do not install documentation to keep image small
echo "path-exclude=/usr/share/locale/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-exclude=/usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-exclude=/usr/share/doc/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc

# update package sources
apt-get update
apt-get -y upgrade

# install of default-jdk-headless fails otherwise on *-slim image
mkdir -p /usr/share/man/man1

# install Debian packages
# `binutils` and `fakeroot` are needed for `packageDeb` task on Desktop
apt-get install -y --no-install-recommends \
	git \
	default-jdk-headless \
	openjdk-17-jdk-headless \
	binutils \
	fakeroot \
	unzip \
	curl \
	wget

# clean up for smaller image size
apt-get -y autoremove --purge
apt-get clean
rm -rf /var/lib/apt/lists/*

################
# Wine Part    #
################

# Install Wine
dpkg --add-architecture i386
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources
apt-get update
apt-get install -y winehq-stable

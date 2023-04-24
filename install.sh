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

# install Debian packages
# `binutils` and `fakeroot` are needed for `packageDeb` task on Desktop
apt-get install -y --no-install-recommends \
	git \
	wget

# clean up for smaller image size
apt-get -y autoremove --purge
apt-get clean
rm -rf /var/lib/apt/lists/*

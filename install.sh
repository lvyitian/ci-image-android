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
apt-get install -y --no-install-recommends \
	git wget \
	libyaml-libyaml-perl libtemplate-perl libdatetime-perl \
	libio-handle-util-perl libio-all-perl \
	libio-captureoutput-perl libjson-perl libpath-tiny-perl \
	libstring-shellquote-perl libsort-versions-perl \
	libdigest-sha-perl libdata-uuid-perl libdata-dump-perl \
	libfile-copy-recursive-perl libfile-slurp-perl \
	mercurial uidmap

# clean up for smaller image size
apt-get -y autoremove --purge
apt-get clean
rm -rf /var/lib/apt/lists/*

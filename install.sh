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
# Android Part #
################

# Install Android SDK Manager
wget --no-verbose -O cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
unzip cmdline-tools.zip
rm cmdline-tools.zip
mkdir -p ${ANDROID_HOME}/cmdline-tools
mv cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest

# Accept all those nasty EULAs
mkdir -p ${ANDROID_HOME}/licenses/
printf "\n8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > ${ANDROID_HOME}/licenses/android-sdk-license
printf "\n84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license
printf "\n79120722343a6f314e0719f863036c702b0e6b2a\n84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license-old

# Install platform-tools, build-tools and platform to prevent re-download each time
mkdir /root/.android
touch /root/.android/repositories.cfg
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;30.0.3"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;31.0.0"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;32.0.0"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-30"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-31"
echo y | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-32"

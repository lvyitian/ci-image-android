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
	git \
	default-jdk-headless \
	unzip \
	wget

# clean up for smaller image size
apt-get -y autoremove --purge
apt-get clean
rm -rf /var/lib/apt/lists/*

################
# Android Part #
################

# Install Android SDK Manager (tools 26.1.1)
wget --no-verbose -O tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
unzip tools.zip
rm tools.zip
mkdir ${ANDROID_HOME}
mv tools ${ANDROID_HOME}/

# Accept all those nasty EULAs
mkdir -p ${ANDROID_HOME}/licenses/
printf "\n8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > ${ANDROID_HOME}/licenses/android-sdk-license
printf "\n84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license
printf "\n79120722343a6f314e0719f863036c702b0e6b2a\n84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license-old

# Install platform-tools, build-tools and platform to prevent re-download each time
mkdir /root/.android
touch /root/.android/repositories.cfg
echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools"
echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;27.0.3"
echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-27"

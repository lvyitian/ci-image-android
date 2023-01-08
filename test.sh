#!/usr/bin/env bash
set -e
set -x

# Would be nice to install this in install.sh, but it looks like this is installed for the current
# user only in ~/.wine/drive_c/... and is not persisted in the build machine.
wget https://dl.winehq.org/wine/wine-mono/7.4.0/wine-mono-7.4.0-x86.msi
wine msiexec /i wine-mono-7.4.0-x86.msi

echo "Testing Briar Desktop"
git clone --recurse-submodules https://code.briarproject.org/briar/briar-desktop.git briar-desktop
cd briar-desktop
git checkout windows-packaging
./gradlew -Dorg.gradle.java.home=/usr/lib/jvm/java-17-openjdk-amd64 --no-daemon pinpitPackageDefault
cd ..
echo "Building Briar Desktop was successful"

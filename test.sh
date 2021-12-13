#!/usr/bin/env bash
set -e
set -x

echo "Testing Briar Desktop"
git clone --recurse-submodules https://code.briarproject.org/briar/briar-desktop.git briar-desktop
cd briar-desktop
./gradlew -Dorg.gradle.java.home=/usr/lib/jvm/java-11-openjdk-amd64 --no-daemon kaptKotlin
./gradlew -Dorg.gradle.java.home=/usr/lib/jvm/java-17-openjdk-amd64 --no-daemon -x kaptKotlin packageDeb
cd ..
echo "Building Briar Desktop was successful"

echo "Testing Briar Android..."
git clone --depth 1 https://code.briarproject.org/briar/briar.git briar
cd briar
./gradlew --no-daemon animalSnifferMain animalSnifferTest test
cd ..
echo "Building Briar Android was successful"

echo "Testing Briar Mailbox..."
git clone --depth 1 https://code.briarproject.org/briar/briar-mailbox.git briar-mailbox
cd briar-mailbox
./gradlew --no-daemon check lint
cd ..
echo "Building Briar Mailbox was successful"

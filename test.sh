#!/usr/bin/env bash
set -e
set -x

git clone --depth 1 https://code.briarproject.org/akwizgran/briar.git briar
cd briar
./gradlew --no-daemon animalSnifferMain animalSnifferTest test

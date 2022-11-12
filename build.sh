#!/bin/sh

BUILDROOT_VERSION="2022.11-rc1"
BUILDROOT_ARCHIVE="buildroot-${BUILDROOT_VERSION}.tar.xz"
BUILDROOT_SIGN="buildroot-${BUILDROOT_VERSION}.tar.xz.sign"
BUILDROOT_SOURCE="https://buildroot.org/downloads/"

if [ ! -f ".extracted" ]; then
  echo "Downloading buildroot..."

  wget "${BUILDROOT_SOURCE}${BUILDROOT_ARCHIVE}"
  wget "${BUILDROOT_SOURCE}${BUILDROOT_SIGN}"

  if ! cat $BUILDROOT_SIGN | grep -q "$(sha256sum $BUILDROOT_ARCHIVE)"; then
    echo "Checksum failed!"
    echo "Got $(sha256sum $BUILDROOT_ARCHIVE)"
    exit 1
  fi

  echo "Extracting buildroot..."
  tar xf "${BUILDROOT_ARCHIVE}"
  ln -s buildroot-${BUILDROOT_VERSION} buildroot
  touch .extracted
fi

cd buildroot
make $@

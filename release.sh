#!/bin/sh

(
  cd buildroot
  make prepare-sdk
)

(
  cd sdk
  mkdir buildroot-sdk-$BUILDROOT_SDK_VERSION
  cd buildroot-sdk-$BUILDROOT_SDK_VERSION
  find . -type f -print0 | xargs -0 sed -i -e "s/@BUILD_DATE@/$(date --iso-8601=seconds)/g"
  find . -type f -print0 | xargs -0 sed -i -e "s/@BUILD_HOST@/$(hostname)/g"
  find . -type f -print0 | xargs -0 sed -i -e "s/@SDK_VERSION@/${SDK_VERSION}/g"
  find . -type f -print0 | xargs -0 sed -i -e "s/@BUILD_DATE@/$(date --iso-8601=seconds)/g"
  dpkg-buildpackage -us -uc
)

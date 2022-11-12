FROM ubuntu:22.10

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
  build-essential \
  libncurses5-dev \
  wget \
  file \
  cpio \
  unzip \
  rsync \
  bc

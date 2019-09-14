FROM ubuntu:16.04

WORKDIR /usr/local/bin/pexa

RUN apt-get update
RUN mkdir /releases

# Install Depdencies
RUN apt-get -y install \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    curl \
    nsis \
    zip \
    g++-mingw-w64-x86-64 \
    mingw-w64-x86-64-dev \
    g++-mingw-w64-i686 \
    mingw-w64-i686-dev

COPY . /usr/local/bin/pexa
COPY ./.docker/devtools/release.sh /usr/local/bin/release.sh

CMD [ "sh" ]
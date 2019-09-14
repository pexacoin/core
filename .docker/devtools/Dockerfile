FROM ubuntu:16.04

WORKDIR /usr/local/bin/pexa

RUN apt-get update
RUN mkdir /releases

# Install Depdencies
RUN apt-get -y install \
    software-properties-common \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    libevent-dev \
    python3 \
    curl \
    nsis \
    zip \
    g++-mingw-w64-x86-64 \
    mingw-w64-x86-64-dev \
    g++-mingw-w64-i686 \
    mingw-w64-i686-dev

# Add bitcoin ppa:bitcoin/bicoin
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update

# Install Dependencines for Cross Compilation on MacOSX
RUN apt-get -y install \
    libminiupnpc-dev \
    libzmq3-dev \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    libqrencode-dev \
    python-pip

RUN pip install setuptools

RUN apt-get -y install \
    cmake \
    libcap-dev \
    libbz2-dev \
    libdb4.8-dev \
    libdb4.8++-dev \
    libboost-all-dev \
    openssl \
    git

ENV OSX_SDK MacOSX10.11.sdk
ENV OSX_CROSS_COMMIT 8aa9b71a394905e6c5f4b59e2b97b87a004658a4
RUN set -x \
	&& export OSXCROSS_PATH="/osxcross" \
	&& git clone https://github.com/tpoechtrager/osxcross.git $OSXCROSS_PATH \
	&& ( cd $OSXCROSS_PATH && git checkout -q $OSX_CROSS_COMMIT) \
	&& curl -sSL https://s3.dockerproject.org/darwin/v2/${OSX_SDK}.tar.xz -o "${OSXCROSS_PATH}/tarballs/${OSX_SDK}.tar.xz" \
	&& UNATTENDED=yes OSX_VERSION_MIN=10.6 ${OSXCROSS_PATH}/build.sh
ENV PATH /osxcross/target/bin:$PATH

COPY . /usr/local/bin/pexa
COPY ./.docker/devtools/release.sh /usr/local/bin/release.sh

CMD [ "sh" ]
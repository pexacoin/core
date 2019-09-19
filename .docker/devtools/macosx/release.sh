#! /bin/bash

while getopts u:d:p:f: option
do
case "${option}"
in
v) PEXA_VERSION=${OPTARG};;
esac
done

update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix
update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix

echo "Building windows 64bit release binaries..."
PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g')
cd depends
make -j4 HOST=x86_64-w64-mingw32
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make -j4

make install DESTDIR=/releases/pexa-v${PEXA_VERSION}-win64/
zip -r /releases/pexa-${PEXA_VERSION}-win64.zip /releases/pexa-v${PEXA_VERSION}-win64/

echo "Building Mac OSX release binaries..."

make -j4 -C depends HOST=x86_64-apple-darwin11
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-apple-darwin11/share/config.site ./configure --prefix=/ --disable-ccache --disable-maintainer-mode --disable-dependency-tracking --with-gui
make -j4
make install DESTDIR=/releases/pexa-v${PEXA_VERSION}-osx/

zip -r /releases/pexa-${PEXA_VERSION}-osx.zip /releases/pexa-v${PEXA_VERSION}-osx/
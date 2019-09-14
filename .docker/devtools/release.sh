#! /bin/bash

echo "Building windows 64bit release binaries..."
PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g')
cd depends
make -j4 HOST=x86_64-w64-mingw32
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make -j4

make install DESTDIR=/releases/windows/pexa/v1.5.1

zip -r /releases/windows/pexa/pexa-1.5.1-win64.zip /releases/windows/pexa/v1.5.1 
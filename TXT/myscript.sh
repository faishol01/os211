#!/bin/sh
dir_now=$(pwd)
if [ "$dir_now" != "/home/faishol01/os211" ]; then
	cd /home/faishol01/os211
fi

cd TXT
rm -f SHA256SUM*

sha256sum my*.txt my*.sh > SHA256SUM
sha256sum -c SHA256SUM

gpg -o SHA256SUM.asc -a -sb SHA256SUM
gpg --verify SHA256SUM.asc SHA256SUM

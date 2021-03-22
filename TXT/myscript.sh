#!/bin/bash
# Taken from https://cbkadal.github.io/os211/TXT/myscript.sh
# Modified by Muhammad Faishol Amirul Mukminin
REC1="operatingsystems@vlsm.org"
REC2="muhammad.faishol@ui.ac.id"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

dir_now=$(pwd)
if [ "$dir_now" != "/home/faishol01/os211" ]; then
	cd /home/faishol01/os211
fi

[ -d $HOME/RESULT ] || { echo "No $HOME/RESULT directory" ; exit; }
pushd $HOME/RESULT
for II in W?? ; do
    [ -d $II ] || continue
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo "tar cfj $TARFILE $II/"
    tar cfj $TARFILE $II/
    echo "gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
    cp $TARFASC $HOME/os211/TXT/$TARFASC
done
popd

cd TXT
rm -f SHA256SUM*

sha256sum $FILES > SHA256SUM
sha256sum -c SHA256SUM

gpg -o SHA256SUM.asc -a -sb SHA256SUM
gpg --verify SHA256SUM.asc SHA256SUM

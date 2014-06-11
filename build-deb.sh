#!/bin/sh

VERSION=`grep 'Version:' pkg-debian/DEBIAN/control | cut -f2 -d' '`

# cleanup first
rm -f example_*_amd64.deb
rm -f example_*_amd64.changes
rm -f pkg-debian/DEBIAN/md5sums

# get the total size of all package files
#TODO: update 'control' file's 'Installed-Size:' property with the correct filesize 
filesize=`du -sk pkg-debian/ | cut -f1`
echo "Package size: $filesize kByte"
sed -i "s/Installed-Size:.*$/Installed-Size: $filesize/" pkg-debian/DEBIAN/control


# regenerate MD5 checksums for all files
(cd pkg-debian; find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums)

# use fakeroot to set owner/group to 0/0 (root/root)
fakeroot dpkg -b pkg-debian/ example_${VERSION}_amd64.deb

echo "Version: $VERSION" >example_${VERSION}_amd64.changes
cat pkg-debian/DEBIAN/changes >>example_${VERSION}_amd64.changes
MD5=`md5sum example_${VERSION}_amd64.deb | cut -f1 -d' '`
SIZE=`wc -c  example_${VERSION}_amd64.deb | cut -f1 -d' '`
SECT=`grep 'Section:' pkg-debian/DEBIAN/control | cut -f2 -d' '`
PRIO=`grep 'Priority:' pkg-debian/DEBIAN/control | cut -f2 -d' '`
echo " $MD5 $SIZE $SECT $PRIO example_${VERSION}_amd64.deb" >>example_${VERSION}_amd64.changes





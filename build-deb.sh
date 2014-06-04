#!/bin/sh

# cleanup first
rm -f example_1.0.0.0-alpha_i386.deb
rm -f pkg-debian/DEBIAN/md5sums

# get the total size of all package files
#TODO: update 'control' file's 'Installed-Size:' property with the correct filesize 
filesize=`du -sk pkg-debian/ | cut -f1`
echo "Package size: $filesize kByte"

# regenerate MD5 checksums for all files
(cd pkg-debian; find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums)

# use fakeroot to set owner/group to 0/0 (root/root)
fakeroot dpkg -b pkg-debian/ example_1.0.0.0-alpha_i386.deb


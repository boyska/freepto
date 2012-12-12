#!/usr/bin/env bash

function out_selfextract() {
	echo '#!/usr/bin/env bash'
	cat pre.sh
	add_tar src.tar.xz /tmp/asd xz
	cat post.sh
}

function add_tar() {
#$1 is filename
#$2 is output dir
#$3 is compression option
	echo "# START: tarball $1"
	echo "base64 -d <<EOTAR |tar --$3 -C$2 -xf -"
	base64 $1
	echo 'EOTAR'
	echo "# END: tarball $1"

}

out_selfextract > magic.sh
chmod +x magic.sh

#!/usr/bin/env bash

function out_selfextract() {
	echo '#!/usr/bin/env bash'
	cat pre.sh
	add_tar files.tar.gz /
	cat post.sh
}

function add_tar() {
#$1 is filename
#$2 is output dir
#$3 is compression option
	if [ -z "$3" ]; then
		case $1 in
			*.xz)	format=xz ;;
			*.gz)	format=gzip ;;
			*.bzip3)	format=bzip2 ;;
			*.tar)	format="" ;;
			*) echo "Can't handle file" >&2 ; exit 1 ;;
		esac
	else
		format=$3
	fi
	echo "# START: tarball $1"
	echo "base64 -d <<EOTAR |tar ${format:+--$format} -C$2 -xf -"
	base64 $1
	echo 'EOTAR'
	echo "# END: tarball $1"

}

out_selfextract > magic.sh
chmod +x magic.sh

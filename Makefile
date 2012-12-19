magic.sh: compiler.sh files.tar.gz tp-tor.tar.gz
	bash compiler.sh

files.tar.gz: files/
	tar -caf $@ -C files home
tp-tor.tar.gz: tp-tor/etc tp-tor/ tp-tor/home tp-tor/usr
	tar -caf $@ -C tp-tor etc home usr

magic.sh: compiler.sh files.tar.gz tp-tor.tar.gz
	bash compiler.sh

files.tar.gz: files/
	tar -caf $@ -C files `find files/ -maxdepth 1 -mindepth 1|xargs realpath --relative-to=files/` 

tp-tor.tar.gz: tp-tor/
	tar -caf $@ -C tp-tor `find tp-tor/ -maxdepth 1 -mindepth 1|xargs realpath --relative-to=tp-tor/` 

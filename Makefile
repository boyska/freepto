magic.sh: compiler.sh files.tar.gz
	bash compiler.sh

files.tar.gz: $(shell find files/)
	tar -caf $@ -C files `find files/ -maxdepth 1 -mindepth 1|xargs realpath --relative-to=files/` 

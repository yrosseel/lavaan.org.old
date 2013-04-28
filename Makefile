build: clean
	jekyll

.PHONY: clean
clean:
	rm -rf _site/*

push: build
	sudo mount.lavaan
	scp -r _site/* /home/yves/mnt/lavaan/WWW
	umount.lavaan

server: clean
	jekyll --server

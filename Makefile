build: clean
	jekyll

deploy: build push

.PHONY: clean
clean:
	rm -rf _site/*

push:
	sudo mount.lavaan
	scp -r _site/* /home/yves/mnt/lavaan/WWW

server: clean
	jekyll --server
